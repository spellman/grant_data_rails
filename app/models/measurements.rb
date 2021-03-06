require "id_validator"
require "date_validator"
require "not_all_domain_fields_blank_validator"
require "parsing"

class Measurements < ActiveRecord::Base
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
      message: "patient already has a set of measurements for this date"
    }
  )
  validates_with(
    NotAllDomainFieldsBlankValidator,
    domain_fields: ["weight_in_pounds", "height_in_inches", "waist_circumference_in_inches"]
  )
  validates(
    :weight_in_pounds,
    :height_in_inches,
    :waist_circumference_in_inches,
    numericality: {
      greater_than_or_equal_to: 0,
      message: "must be a non-negative number"
    },
    allow_blank: true
  )

  def self.display_name
    "measurements"
  end
end
