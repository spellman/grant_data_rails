require "id_validator"
require "date_validator"
require "not_all_domain_fields_blank_validator"

class Measurements < ActiveRecord::Base
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
  validates_with NotAllDomainFieldsBlankValidator,
    domain_fields: ["weight_in_pounds", "height_in_inches", "waist_circumference_in_inches"]
  validates :weight_in_pounds,
            :height_in_inches,
            :waist_circumference_in_inches,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    },
    allow_blank: true
end
