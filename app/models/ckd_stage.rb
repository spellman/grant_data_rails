require "date_timeliness_validator"

class CkdStage < ActiveRecord::Base
  belongs_to :patient
  validates :patient,
    presence: true
  validates :ckd_stage,
    numericality: {
      only_integer:             true,
      greater_than_or_equal_to: 0,
      message:                  "must be a non-negative number with no decimal places"
    }
  validates :date,
    presence:        true,
    date_timeliness: true
end
