require "csv"

class Record < ActiveRecord::Base
  belongs_to :patient
  validates :patient,
    presence: true

  validates :bmi,
            :a1c,
    numericality: {
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative number"
    },
    allow_blank:  true
  validates :tc,
            :tg,
            :hdl,
            :ldl,
            :acr,
            :bun,
            :creatinine,
            :ckd_stage,
            :ast,
            :alt,
    numericality: {
      only_integer:             true,
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative, whole number"
    },
    allow_blank:  true

  validate :some_domain_fields_non_empty?

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end

  # private
  def some_domain_fields_non_empty?
    errors.add(:base, "Please enter some patient data") if domain_fields_empty?
  end

  def domain_fields_empty?
    attributes.reject { |k, v| Record.non_domain_fields.include?(k) || v.blank? }.empty?
  end

  def self.non_domain_fields
    ["id", "patient_id", "created_at", "updated_at"]
  end
end
