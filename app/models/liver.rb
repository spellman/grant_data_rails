require "id_validator"
require "time_with_zone_validator"
require "not_all_domain_fields_blank_validator"

class Liver < ActiveRecord::Base
  belongs_to :patient

  include I18n::Alchemy
  localize :date, using: :date

  validates :patient_id,
    id:       true,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  validates :date,
    presence:       true,
    time_with_zone: true
  validates_with NotAllDomainFieldsBlankValidator,
    domain_fields: ["ast", "alt"]
  validates :ast,
            :alt,
    numericality: {
      only_integer:             true,
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative number with no decimal places"
    },
    allow_blank: true
end
