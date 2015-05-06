class Meeting < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  mount_uploader :cover_photo, CoverPhotoUploader

  # split datetime in date and time
  date_time_attribute :starts_at
  date_time_attribute :ends_at

  # associations
  has_and_belongs_to_many :graetzls

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :going_tos
  has_many :users, through: :going_tos

  has_and_belongs_to_many :categories

  # validations
  validates :name, presence: true
  validates :description, presence: true
  validate :starts_at_cannot_be_in_the_past
  validate :ends_at_cannot_be_before_starts_at

  # instance methods
  def complete_datetimes
    if self.ends_at_time
      self.ends_at_date = self.starts_at_date || Time.now
    end
  end

  private

    def starts_at_cannot_be_in_the_past
      if starts_at && starts_at < Date.today
        errors.add(:starts_at, 'kann nicht in der Vergangenheit liegen')
      end
    end

    def ends_at_cannot_be_in_the_past
      if ends_at && ends_at < Date.today
        errors.add(:ends_at, 'kann nicht in der Vergangenheit liegen')
      end
    end

    def ends_at_cannot_be_before_starts_at
      if starts_at && ends_at && ends_at < starts_at
        errors.add(:ends_at, 'kann nicht vor Beginn liegen')
      end
    end

end
