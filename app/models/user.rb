class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :welcome_send

  validates :encrypted_password,
            presence: true,
            length: { minimum: 6 }

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[^@\s]+@([^@\s]+.)+[^@\s]+\z/,
              message: 'email adress please'
            }
  
  has_many :attendances
  has_many :events, through: :attendances
  has_many :organised_events, foreign_key: 'organizer', class_name: 'Event'

  private

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
