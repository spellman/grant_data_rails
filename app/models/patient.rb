class Patient < ActiveRecord::Base
  has_many :records

  validates :name,
            :diagnosis,
    presence: true,
    length:   { maximum: 255 }
end
