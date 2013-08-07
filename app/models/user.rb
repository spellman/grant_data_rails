class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :confirmable
  # :lockable
  # :timeoutable
  # :omniauthable
  # :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
