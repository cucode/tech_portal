require "open-uri"

class Feed < ActiveRecord::Base

  # Relationships and Scopes

  has_many :events, dependent: :destroy
  belongs_to :organization
  scope :published,   -> { Feed.joins(:organization).where(organizations: { published: true }) }
  scope :unpublished, -> { Feed.joins(:organization).where(organizations: { published: false }) }

  # Scopes

  # Public Methods

  def import_events!
    if organization.try(:unpublished?)
      throw "Not allowed to import events if Organization is unpublished."
    end

    ical = Icalendar.parse(open(uri))
    return unless ical.first.present?

    ical.first.events.each do |event|
      Event.create( # Won't save the event if it's already in the database.
        summary:     event.summary,
        description: event.description,
        dtend:       event.dtend,
        dtstart:     event.dtstart,
        feed:        Feed.first,
        location:    event.location,
        uid:         event.uid,
        url:         event.url.to_s)
    end
  end

end
