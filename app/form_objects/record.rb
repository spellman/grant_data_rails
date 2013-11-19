class Record
  class CouldNotSaveAllModels < StandardError
  end

  attr_accessor :patient_id, :models, :errors

  def initialize params = default_attributes
    params      = Hash[params.map { |k, v| [k.to_s, v] }]
    @patient_id = params.delete "patient_id"
    @models     = []
    @errors     = ErrorAggregator.new
    initialize_models params
  end

  def save
    validate_some_model_not_blank && try_save
  end

  def try_save
    begin
      save_models!
      true
    rescue CouldNotSaveAllModels
      errors.aggregate_errors_from models
      false
    end
  end

  # private
  def default_attributes
    attr_names = [
      "a1c",
      "acr",
      "bmi",
      "cholesterol",
      "ckd_stage",
      "eye_exam",
      "flu",
      "foot_exam",
      "liver",
      "pneumonia",
      "renal"
    ]
    Hash[attr_names.map { |attr_name| [attr_name, {}] }]
  end

  def initialize_models params
    params.each do |model_name, model_attrs|
      initialize_model name:       model_name,
                       attributes: model_attrs.merge({ "patient_id" => patient_id })
    end
  end

  def initialize_model name: nil, attributes: nil
    model_class = name.titlecase.gsub("\s", "").constantize
    model       = model_class.send :new, attributes
    models << model
    define_attr_reader name: name, model: model
  end

  def define_attr_reader name: nil, model: nil
    return unless name && model
    instance_variable_set "@#{name}", model
    class_eval <<-EOS
      def #{name}
        @#{name}
      end
    EOS
  end

  def save_models!
    ActiveRecord::Base.transaction do
      save_results = []
      models.each do |model|
        save_results << model.save unless all_input_fields_blank_in?(model)
      end
      raise CouldNotSaveAllModels unless save_results.all?
    end
  end

  def validate_some_model_not_blank
    if all_models_blank?
      errors.add_full_error_message "Please enter some patient data" 
      false
    else
      true
    end
  end

  def all_models_blank?
    models.all? { |model| all_input_fields_blank_in? model }
  end

  def all_input_fields_blank_in? model
    model.attributes.reject { |k, v| k == "patient_id" }.all? { |k, v| v.blank? }
  end
end
