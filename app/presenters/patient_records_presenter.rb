class PatientRecordsPresenter
  attr_reader :patient, :model_names

  def initialize patient
    @patient = patient
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
    model_names.reduce({}) { |acc, model_name|
      acc[model_name.to_sym] = sort(data_from_records(patient_records_of_type(model_name)))
      acc
    }
  end

  # private
  def patient_records_of_type model_name
    patient.send model_name.pluralize
  end

  def data_from_records records
    records.map { |record|
      record.attributes.keys.reduce({}) { |acc, attr_name|
        r = attr_name == "date" ? record.localized : record
        acc[attr_name.to_sym] = r.send(attr_name.to_sym).to_s
        acc
      }
    }
  end

  def sort records
    records.sort_by { |record| record[:date] }
  end
end
