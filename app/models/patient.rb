class Patient < ActiveRecord::Base
  has_many :records
end
