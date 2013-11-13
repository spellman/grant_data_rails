class PatientRecordsPresenter
  attr_reader :records

  def initialize records = []
    @records = records
  end

  def index
    format_dates_in sort_records_by_date_in records_hash
  end

  # private
  def records_hash
    records_hash = {
      bmi:            [],
      eye_exam_date:  [],
      foot_exam_date: [],
      a1c:            [],
      cholesterol:    [],
      acr:            [],
      renal:          [],
      ckd_stage:      [],
      liver:          [],
      flu_date:       [],
      pneumonia_date: []
    }

    records.each do |record|
      records_hash[:bmi] << {
        value: record.bmi,
        date:  record.bmi_date
      } if record.bmi_date
      records_hash[:eye_exam_date] << {
        date: record.eye_exam_date
      } if record.eye_exam_date
      records_hash[:foot_exam_date] << {
        date: record.foot_exam_date
      } if record.foot_exam_date
      records_hash[:a1c] << {
        value: record.a1c,
        date:  record.a1c_date
      } if record.a1c_date
      records_hash[:cholesterol] << {
        value: {
          tc:  record.tc,
          tg:  record.tg,
          hdl: record.hdl,
          ldl: record.ldl
        },
        date: record.cholesterol_date
      } if record.cholesterol_date
      records_hash[:acr] << {
        value: record.acr,
        date:  record.acr_date
      } if record.acr_date
      records_hash[:renal] << {
        value: {
          bun:        record.bun,
          creatinine: record.creatinine
        },
        date: record.bun_creatinine_date
      } if record.bun_creatinine_date
      records_hash[:ckd_stage] << {
        value: record.ckd_stage,
        date:  record.ckd_stage_date
      } if record.ckd_stage_date
      records_hash[:liver] << {
        value: {
          ast: record.ast,
          alt: record.alt
        },
        date: record.ast_alt_date
      } if record.ast_alt_date
      records_hash[:flu_date] << {
        date: record.flu_date
      } if record.flu_date
      records_hash[:pneumonia_date] << {
        date: record.pneumonia_date
      } if record.pneumonia_date
    end

    records_hash
  end

  def sort_records_by_date_in hash
    sorted = hash.map do |data_point_type, data_points|
      [data_point_type, data_points.sort { |a, b| a[:date] <=> b[:date] }]
    end
    Hash[sorted]
  end

  def format_dates_in hash
    formatted = hash.map do |data_point_type, data_points|
      [data_point_type, format_dates_in_data_points(data_points)]
    end
    Hash[formatted]
  end

  def format_dates_in_data_points data_points
    data_points.map do |h|
      h[:value] ?
        { value: h[:value], date: format_date(h[:date]) } :
        { date: format_date(h[:date]) }
    end
  end

  def format_date date
    return nil unless date
    date.in_time_zone("Central Time (US & Canada)").strftime("%_m/%d/%Y")
  end
end
