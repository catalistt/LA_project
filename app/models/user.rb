class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :clients
  has_many :consumes
  has_many :resources, through: :consume
  has_many :orders
  enum gender: [:masculino, :femenino, :otro]
  accepts_nested_attributes_for :orders, allow_destroy: true

end
