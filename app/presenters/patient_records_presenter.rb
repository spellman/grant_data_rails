class PatientRecordsPresenter
  attr_reader :patient, :model_names

  def initialize patient
    @patient     = patient
    @model_names = [
      "a1c",
      "acr",
      "blood_pressure",
      "bun_and_creatinine",
      "cholesterol",
      "ckd_stage",
      "eye_exam",
      "foot_exam",
      "measurements",
      "testosterone"
    ]
  end

  def index
    data = {}
    model_names.each do |model_name|
      data[model_name.to_sym] = data_from_records patient_records_of_type model_name
    end
    data
  end

  # private
  def patient_records_of_type model_name
    patient.send model_name.pluralize
  end

  def data_from_records records
    records.map { |record| data_from_record record }
  end

  def data_from_record record
    data = {}
    record.attributes.keys.each do |attr_name|
      r = attr_name == "date" ? record.localized : record
      data[attr_name.to_sym] = r.send(attr_name.to_sym).to_s
    end
    data
  end
end
