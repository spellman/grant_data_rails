require "date_validator"

class Patient < ActiveRecord::Base
  has_many :a1cs
  has_many :acrs
  has_many :blood_pressures
  has_many :bun_and_creatinines
  has_many :cholesterols
  has_many :ckd_stages
  has_many :eye_exams
  has_many :foot_exams
  has_many :measurements, class_name: "Measurements"
  has_many :testosterones

  validates :study_assigned_id,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true,
      message: "must be a non-negative number with no decimal places"
    },
    uniqueness: true
  validates :birthdate,
    presence: true,
    date: true
end
