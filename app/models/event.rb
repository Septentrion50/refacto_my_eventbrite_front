class Event < ApplicationRecord
  validates :start_date,
            presence: true,
            numericality: { greater_than_or_equal_to: Time.now.to_i }

  validates :duration,
            presence: true, if: :mult_5_and_positive?

  validates :title,
            presence: true,
            length: { minimum: 5, maximum: 140 }

  validates :description,
            presence: true,
            length: { minimum: 20, maximum: 1000 }

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }

  validates :location,
            presence: true

  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :organizer, class_name: 'User'

  def end_date
    self.start_date + self.duration * 60
  end

  private

  def mult_5_and_positive?
    return true if self.duration % 5 == 0 && self.duration > 0

    false
  end
end
