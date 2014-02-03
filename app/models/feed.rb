require "open-uri"

class Feed < ActiveRecord::Base

  # Relationships and Scopes

  has_many :events, dependent: :destroy
  belongs_to :organization
  scope :published,   -> { Feed.joins(:organization).where(organizations: { published: true }) }
  scope :special,     -> { Feed.where(organization_id: nil) }
  scope :unpublished, -> { Feed.joins(:organization).where(organizations: { published: false }) }


  # Validations

  validates :uri, presence: true, format: /\A(http|webcal).*/


  # Public Properties

  def special?
    organization.nil?
  end


  # Public Methods

  def import_events!
    if organization.try(:unpublished?)
      throw "Not allowed to import events if Organization is unpublished."
    end

    ical = Icalendar.parse(open(uri.gsub(/\Awebcal:\/\//, "http://")))
    return unless ical.first.present?

    ical.first.events.each do |event|
      Event.create( # Won't save the event if it's already in the database.
        summary:     event.summary,
        description: event.description,
        dtend:       event.dtend,
        dtstart:     event.dtstart,
        feed:        self,
        location:    event.location,
        published:   !special?,
        uid:         event.uid,
        url:         event.url.to_s)
    end
  end

end
