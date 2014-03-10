require "id_validator"
require "date_validator"

class BloodPressure < ActiveRecord::Base
  belongs_to :patient

  include I18n::Alchemy
  localize :date, using: :date

  validates :patient_id,
    id: true,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
#    uniqueness: {
#      scope: :date,
#      message: "patient already has an A1c for this date"
#    }
  validates :date,
    presence: true,
    date: true
  validates :systolic_in_mmhg,
            :diastolic_in_mmhg,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    }
end
