class Attendance < ApplicationRecord

  after_create :inscription_email

  validates :stripe_customer_id,
            presence: true

  belongs_to :user
  belongs_to :event

  private

  def inscription_email
    UserMailer.event_inscription_email(self.user, self.event).deliver_now
  end
end
