class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  belongs_to :role
  has_many :loans, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates_presence_of :name, :surname

  before_validation :set_role

  def set_role
    self.role = Role.find_by(name: "user") if role_id.nil?
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = 'password'
      user.surname = auth.info.name
      user.save
    end
  end
end
