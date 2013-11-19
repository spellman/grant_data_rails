class PatientRecordsPresenter
  attr_reader :patient, :model_names

  def initialize patient
    @patient     = patient
    @model_names = [
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
  end

  def index
    format_dates_in data_hash
  end
  
  # private
  def data_hash
    data_hash = {}
    model_names.each do |model_name|
      data_hash[model_name] = []
      records = patient_records_of_type model_name
      add_data_from_records records: records, to: data_hash[model_name]
    end
    data_hash.symbolize_keys
  end

  def patient_records_of_type model_name
    patient.send (model_name + "s").to_sym
  end

  def add_data_from_records records: nil, to: nil
    records.each { |record| to << record.attributes.symbolize_keys }
  end

  def format_dates_in hash
    formatted = hash.map do |model_name, records|
      [model_name, formatted_records(records)]
    end
    Hash[formatted]
  end

  def formatted_records records
    records.map { |record| format_record record }
  end

  def format_record record
    formatted = record.map do |attr_name, attr_value|
      attr_name == :date ?
        [attr_name, format_date(attr_value)] :
        [attr_name, attr_value]
    end
    Hash[formatted]
  end

  def format_date date
    return nil unless date
    date.in_time_zone("Central Time (US & Canada)").strftime("%_m/%d/%Y")
  end
end
