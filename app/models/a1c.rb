require "id_validator"
require "date_validator"
require "parsing"

class A1c < ActiveRecord::Base
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
      message: "patient already has an A1c for this date"
    }
  )
  validates(
    :a1c,
    numericality: {
      greater_than_or_equal_to: 0,
      message: "must be a non-negative number"
    }
  )

  def self.display_name
    "A1c"
  end
end
