require "id_validator"
require "date_validator"

class Pneumonia < ActiveRecord::Base
  self.table_name = "pneumonias"
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
  validates :date,
    presence: true,
    date: true
end
