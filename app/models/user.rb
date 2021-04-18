class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_many :clients
  has_many :consumes
  has_many :resources, through: :consume
  has_many :orders
  enum gender: [:masculino, :femenino, :otro]

  before_save :clean_rut
  validates :rut, presence: true, uniqueness: true
  accepts_nested_attributes_for :orders, allow_destroy: true

  def clean_rut
    self.rut = rut.gsub(/[^0-9A-Za-z ]/i, '')
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.iud).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def to_s
    name
  end

end
