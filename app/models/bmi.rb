require "id_validator"
require "date_validator"

class Bmi < ActiveRecord::Base
  belongs_to :patient

  validates :patient_id,
    id: true,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  validates :date,
    presence: true,
    date: true
  validates :bmi,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      message: "must be a non-negative number"
    }
end
