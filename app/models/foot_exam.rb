require "id_validator"
require "date_validator"
require "parsing"

class FootExam < ActiveRecord::Base
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
      message: "patient already has a foot exam for this date"
    }
  )

  def self.display_name
    "foot exam"
  end
end
