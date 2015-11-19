require "id_validator"
require "date_validator"
require "parsing"

class Cholesterol < ActiveRecord::Base
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
      message: "patient already has a cholesterol for this date"
    }
  )
  validates(
    :ldl_in_mg_per_dl,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    }
  )

  def self.display_name
    "cholesterol"
  end
end
