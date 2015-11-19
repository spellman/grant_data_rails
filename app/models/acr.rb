require "id_validator"
require "date_validator"
require "parsing"

class Acr < ActiveRecord::Base
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
      message: "patient already has an ACR for this date"
    }
  )
  validates(
    :acr_in_mcg_alb_per_mg_cr,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    }
  )

  def self.display_name
    "ACR"
  end
end
