class Event < ActiveRecord::Base

  # Mixins
  publishable


  # Relationships

  belongs_to :feed


  # Validations

  validates :summary,     presence: true
  validates :description, presence: true
  validates :dtend,       presence: true
  validates :dtstart,     presence: true
  validates :feed,        presence: true
  validates :location,    presence: true
  validates :uid,         presence: true, uniqueness: true
  validates :url,         presence: true

end
