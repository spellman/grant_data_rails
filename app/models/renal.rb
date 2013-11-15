require "date_timeliness_validator"
require "not_all_domain_fields_blank_validator"

class Renal < ActiveRecord::Base
  belongs_to :patient
  validates :patient,
    presence: true
  validates :bun,
            :creatinine,
    numericality: {
      only_integer:             true,
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative number with no decimal places"
    },
    allow_blank:  true,
    not_all_domain_fields_blank: {
      domain_fields: ["bun", "creatinine"]
    }
  validates :date,
    presence:        true,
    date_timeliness: true
end
