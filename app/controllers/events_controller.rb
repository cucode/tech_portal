class EventsController < ApplicationController
  def index
    e = Feedzirra::Feed.fetch_and_parse("http://illinois.edu/calendar/rss/3462.xml").entries
    @events = Kaminari.paginate_array(e).page(params[:page]).per(10)
  end
end
