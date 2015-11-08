require "date_validator"

module Export
  def to_csv(patients, options = {})
    d = export_data(patients)
    CSV.generate(options) do |csv|
      csv << d[:columns]
      d[:rows].each do |row|
        csv << row
      end
    end
  end

  def record_types
    [
      A1c,
      Acr,
      BloodPressure,
      BunAndCreatinine,
      Cholesterol,
      CkdStage,
      EyeExam,
      FootExam,
      Measurements,
      Testosterone
    ]
  end

  def export_data patients
    ps = patients.map { |p| export_patient_data(p) }
    rss = patients.map { |p| export_records_data(p) }

    p_keys = ps.reduce([]) { |acc, p| acc + p[:keys] }.uniq
    r_keys = rss.flatten
                .group_by { |r| r[:record_type] }
                .map { |type, rs|
                  [type, rs.flat_map { |r| r[:keys] }
                           .uniq
                           .sort { |a, b| column_sort(a, b) }]
                }.sort { |a, b| a.first <=> b.first }
                .flat_map { |type, keys| keys }


    all_keys = p_keys + r_keys
    all_keys_no_vals_hash = Hash[all_keys.zip([nil].cycle)]

    all_records = ps.map { |p| all_keys_no_vals_hash.merge(p[:record]) }
                    .zip(rss)
                    .flat_map { |p, rs|
                      rs.flat_map { |r| r[:records] }
                        .map { |r| p.merge(r).values }
                    }
    {columns: all_keys, rows: all_records}
  end

  def column_sort a, b
    # Order: 1. Dates
    #        2. Non-dates and non-timestamps
    #        3. Timestamps
    # Default order within each sort region.
    if (timestamp?(a) && timestamp?(b)) ||
      (date?(a) && date?(b)) ||
      !((timestamp?(a) || timestamp?(b)) ||
        (date?(a) || date?(b)))
      a <=> b
    elsif date?(a) && !date?(b)
      -1
    elsif !date?(a) && date?(b)
      1
    elsif timestamp?(a) && !timestamp?(b)
      1
    else
      -1
    end
  end

  def timestamp? s
    ["created_at", "updated_at"].any? { |t| s.match(t) }
  end

  def date? s
    s.match("date") && !timestamp?(s)
  end

  def export_patient_data patient
    columns = export_columns(Patient)
    attrs = patient.attributes.select { |k, v| columns.include?(k) }
    {keys: attrs.keys, record: attrs}
  end

  def export_records_data patient
    record_types.map { |record_type|
      active_record_result = record_type.connection.select_all(%Q[
        SELECT #{query_columns(record_type)}
        FROM #{record_type.table_name}
        WHERE patient_id = #{patient.id}
      ])

      keys = active_record_result.columns
      records = active_record_result.rows.map { |vals| Hash[keys.zip(vals)] }

      {record_type: model_name(record_type),
       keys: keys,
       records: records}
    }
  end

  def query_columns record_type
    model_name = model_name(record_type)
    columns = export_columns(record_type)
    alias_names = columns.map { |column_name|
      transform_column_name(model_name, column_name)
    }
    columns.zip(alias_names).map { |pair|
      column, alias_name = *pair
      column == alias_name ? column : "#{column} AS #{alias_name}"
    }.join(", ")
  end

  def model_name model_class
    model_class.to_s.underscore
  end

  def export_columns model_class
    model_class.column_names.reject { |column_name|
      ["id", "patient_id"].include?(column_name)
    }
  end

  def transform_column_name model_name, column_name
    case column_name
    when "date"
      "#{model_name}_#{column_name}"
    when "created_at", "updated_at"
      "#{model_name}_#{column_name}"
    else
      column_name
    end
  end

  extend self
end

class Patient < ActiveRecord::Base
  has_many :a1cs
  has_many :acrs
  has_many :blood_pressures
  has_many :bun_and_creatinines
  has_many :cholesterols
  has_many :ckd_stages
  has_many :eye_exams
  has_many :foot_exams
  has_many :measurements, class_name: "Measurements"
  has_many :testosterones

  validates :study_assigned_id,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    },
    uniqueness: true
  validates :birthdate,
    presence: true,
    date: true
end
