class User < ApplicationRecord

  after_create :welcome_send

  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :encrypted_password,
            presence: true,
            length: { minimum: 6, maximum: 20 }

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
