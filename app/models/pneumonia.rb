require "date_timeliness_validator"

class Pneumonia < ActiveRecord::Base
  self.table_name = "pneumonias"
  belongs_to :patient
  validates :patient,
    presence: true
  validates :date,
    presence:        true,
    date_timeliness: true
end
