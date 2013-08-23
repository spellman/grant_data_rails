class User < ActiveRecord::Base
  has_secure_password
  validates :password,
    length:       8..127

  validates :email,
    presence:   true,
    length:     { minimum: 3 },
    uniqueness: true
end
