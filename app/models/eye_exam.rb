require "id_validator"
require "date_validator"
require "parsing"

class EyeExam < ActiveRecord::Base
  after_initialize Parsing.new([:date])

  belongs_to :patient

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

  def self.display_name
    "eye exam"
  end
end
