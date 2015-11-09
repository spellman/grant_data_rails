require "date_validator"

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

  class << self
    def to_csv(patients, options = {})
      d = export_data(patients)
      CSV.generate(options) do |csv|
        csv << d[:columns]
        d[:rows].each do |row|
          csv << row
        end
      end
    end

    def export_data(patients)
      result = Patient.connection.select_all(
        union_query(record_types, patients)
      )
      {columns: result.columns, rows: result.rows}
    end

    def union_query(record_types, patients)
      all_columns = all_attr_columns(record_types)
      record_types.map { |r| union_sub_query(all_columns, patients, r) }
        .join(" UNION ") + " " + order_by(record_types)
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

    def order_by(record_types)
      "ORDER BY " +
      "study_assigned_id ASC, " +
      record_types.sort { |a, b| a.model_name.singular <=> b.model_name.singular }
        .map { |r|
          "#{alias_column(r.model_name.singular, "date")} ASC"
        }.join(", ")
    end

    def union_sub_query(all_columns, patients, record_type)
      patient_table = Patient.table_name
      record_table = record_type.table_name
      patient_columns = format_columns(all_attr_columns([Patient]), Patient)
      attr_columns = format_columns(all_columns, record_type)
      join_criteria = "#{record_table}.patient_id = #{patient_table}.id"
      patient_filter = "AND #{patient_table}.id IN (#{patients.map(&:id).join(", ")})"

      %Q[SELECT #{patient_columns}, #{attr_columns} FROM #{patient_table}, #{record_table} WHERE #{join_criteria} #{patient_filter}]
    end

    def format_columns(columns, record_type)
      table = record_type.table_name
      union_query_record_columns(columns, record_type).map { |c|
        n = c[:name]
        a = c[:alias]
        t = c[:sql_type]
        table_n = n ? "#{table}.#{n}" : "CAST (NULL AS #{t.upcase})"
        as_a = a ? " AS #{a}" : a
        "#{table_n}#{as_a}"
      }.join(", ")
    end

    def union_query_record_columns(all_columns, record_type)
      all_columns.flat_map { |model, columns|
        nil_fill_non_existant_columns(record_type, model, columns)
      }
    end

    def nil_fill_non_existant_columns(record_type, model, columns)
      columns.map { |column|
        n = record_type.model_name.singular == model ? column[:name] : nil
        a = if n
              column[:alias]
            else
              column[:alias] || column[:name]
            end
        {
          :name => n,
          :alias => a,
          :sql_type => column[:sql_type]
        }
      }
    end

    def all_attr_columns(record_types)
      Hash[record_types.map { |r| [r.model_name.singular, query_columns(r)] }]
    end

    def query_columns(record_type)
      r = record_type.model_name.singular
      export_columns(record_type).map { |column|
        {
          :name => column.name,
          :alias => alias_column(r, column.name),
          :sql_type => column.sql_type
        }
      }
    end

    def export_columns(model_class)
      model_class.columns.reject { |column|
        ["id", "patient_id"].include?(column.name)
      }
    end

    def alias_column(model_name, column_name)
      case column_name
      when "date"
        "#{model_name}_#{column_name}"
      when "created_at", "updated_at"
        "#{model_name}_#{column_name}"
      else
        nil
      end
    end
  end
end
