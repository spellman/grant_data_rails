require "id_validator"
require "date_validator"
require "parsing"

class CkdStage < ActiveRecord::Base
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
      message: "patient already has a CKD stage for this date"
    }
  )
  validates(
    :ckd_stage,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    }
  )

  def self.display_name
    "CKD stage"
  end
end
