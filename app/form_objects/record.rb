class Record
  include ActiveModel::Model
  CouldNotSaveAllModels = Class.new(StandardError)

  def self.model_names
    Patient.record_types.map { |r| r.model_name.singular }
  end

  attr_accessor :models, *self.model_names.map(&:to_sym)

  def initialize(params = {})
    @models = initialize_models(default_attributes.merge(params))
    @models.each do |m| self.send("#{m.model_name.singular}=", m) end
  end

  validate :some_model_not_blank
  validate :aggregate_model_errors

  def save
    if valid?
      try_save_models
    end
  end

  # private
  def default_attributes
    Hash[self.class.model_names.zip([{}].cycle)]
  end

  def initialize_models(params)
    patient_id = params.delete("patient_id")

    params.map do |name, attrs|
      model_class = Patient.record_types.select { |r|
        r.model_name.singular == name
      }.first
      model_class.new(attrs.merge({"patient_id" => patient_id}))
    end
  end

  def try_save_models
    begin
      save_models!
      true
    rescue CouldNotSaveAllModels
      aggregate_model_errors
      false
    end
  end

  def save_models!
    ActiveRecord::Base.transaction do
      save_results = []
      non_blank_models.each do |model| save_results << model.save end
      raise(CouldNotSaveAllModels) unless save_results.all?
    end
  end

  def some_model_not_blank
    errors.add(:base, "Nothing to save! Please enter some patient data.") if non_blank_models.empty?
  end

  def aggregate_model_errors
    non_blank_models.reverse.each do |model|
      unless model.valid?
        model.errors.each do |key, values|
          errors[key] = values
        end
      end
    end
  end

  def non_blank_models
    models.reject { |model| blank_model?(model) }
  end

  def blank_model?(model)
    model.attributes.reject { |k, v| k == "patient_id" }.all? { |k, v| v.blank? }
  end
end
