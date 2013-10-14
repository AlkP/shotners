class User < ActiveRecord::Base
  has_secure_password

  has_many :shotners, dependent: :destroy

  attr_accessible :name, :email, :password, :password_confirmation, :country

  validates_presence_of :email
  validates_uniqueness_of :email
end
