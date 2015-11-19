require "id_validator"
require "date_validator"
require "parsing"

class BloodPressure < ActiveRecord::Base
  after_initialize Parsing.new([:date])

  belongs_to :patient

  validates(
    :patient_id,
    id: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  )
  validates(
    :date,
    date: true,
    uniqueness: {
      scope: :patient_id,
      message: "patient already has a blood pressure for this date"
    }
  )
  validates(
    :systolic_in_mmhg,
    :diastolic_in_mmhg,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    }
  )

  def self.display_name
    "blood pressure"
  end
end
