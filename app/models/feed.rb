require "open-uri"

class Feed < ActiveRecord::Base

  # Relationships

  has_many :events, dependent: :destroy
  belongs_to :organization


  # Public Methods

  def import_events!
    ical = Icalendar.parse(open(uri))
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
