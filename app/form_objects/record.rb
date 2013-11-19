class Record
  class CouldNotSaveAllModels < StandardError
  end

  attr_accessor :patient_id, :models, :errors, :a1c, :acr, :bmi, :cholesterol,
    :eye_exam, :ckd_stage, :flu, :foot_exam, :liver, :pneumonia, :renal

  def initialize params = {
                            "a1c"         => {},
                            "acr"         => {},
                            "bmi"         => {},
                            "cholesterol" => {},
                            "ckd_stage"   => {},
                            "eye_exam"    => {},
                            "flu"         => {},
                            "foot_exam"   => {},
                            "liver"       => {},
                            "pneumonia"   => {},
                            "renal"       => {}
                          }
    params      = Hash[params.map { |k, v| [k.to_s, v] }]
    @patient_id = params.delete "patient_id"
    @models     = {}
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
      errors.aggregate_errors_from models.values
      false
    end
  end

  # private
  def initialize_models params
    params.each do |model_name, model_attrs|
      initialize_model name:       model_name,
                       attributes: model_attrs.merge({ "patient_id" => patient_id })
    end
  end

  def initialize_model name: nil, attributes: nil
    model_class = name.titlecase.gsub("\s", "").constantize
    model       = model_class.send :new, attributes
    send "#{name}=", model
    models[name] = model
  end

  def save_models!
    ActiveRecord::Base.transaction do
      save_results = []
      models.values.each do |model|
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
    models.values.all? { |model| all_input_fields_blank_in? model }
  end

  def all_input_fields_blank_in? model
    model.attributes.reject { |k, v| k == "patient_id" }.all? { |k, v| v.blank? }
  end
end
