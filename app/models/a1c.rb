require "id_validator"
require "date_validator"

class A1c < ActiveRecord::Base
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
  validates :a1c,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      message: "must be a non-negative number"
    }
end
