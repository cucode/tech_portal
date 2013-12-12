class Event < ActiveRecord::Base

  # Mixins

  publishable
  mount_uploader :event_photo, EventPhotoUploader


  # Relationships and scopes

  belongs_to :feed
  has_one :organization, through: :feed
  scope :blogged, -> { where.not(blog_content: [nil, ""]) }


  # Validations

  validates :blog_content, presence: true, if: :event_photo_url
  validates :summary,     presence: true
  validates :description, presence: true
  validates :dtend,       presence: true
  validates :dtstart,     presence: true
  validates :feed,        presence: true
  validates :uid,         presence: true, uniqueness: true
  validates :url,         presence: true


end
