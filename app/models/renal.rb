require "id_validator"
require "date_timeliness_validator"
require "not_all_domain_fields_blank_validator"

class Renal < ActiveRecord::Base
  belongs_to :patient
  validates :patient_id,
    id:       true,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  validates :date,
    presence:        true,
    date_timeliness: true
  validates_with NotAllDomainFieldsBlankValidator,
    domain_fields: ["bun", "creatinine"]
  validates :bun,
            :creatinine,
    numericality: {
      only_integer:             true,
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative number with no decimal places"
    },
    allow_blank: true
end
