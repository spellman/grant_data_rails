class Patient < ActiveRecord::Base
  has_many :records
  has_many :a1cs
  has_many :acrs
  has_many :bmis
  has_many :cholesterols
  has_many :ckd_stages
  has_many :eye_exams
  has_many :foot_exams
  has_many :flus
  has_many :livers
  has_many :pneumonias, class_name: "Pneumonia"
  has_many :renals

  validates :name,
            :diagnosis,
    presence: true,
    length:   { maximum: 255 }
end
