require "id_validator"
require "date_validator"
require "not_all_domain_fields_blank_validator"
require "parsing"

class BunAndCreatinine < ActiveRecord::Base
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
  validates_with NotAllDomainFieldsBlankValidator,
    domain_fields: ["bun_in_mg_per_dl", "creatinine_in_mg_per_dl"]
  validates :bun_in_mg_per_dl,
            :creatinine_in_mg_per_dl,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    },
    allow_blank: true

  def self.display_name
    "BUN and creatinine"
  end
end