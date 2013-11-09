require "csv"

class Record < ActiveRecord::Base
  belongs_to :patient
  validates :patient,
    presence: true

  validates :bmi,
            :a1c,
    numericality: { greater_than_or_equal_to: 0 },
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
    numericality: { integer_only: true, greater_than_or_equal_to: 0 },
    allow_blank:  true

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end
end
