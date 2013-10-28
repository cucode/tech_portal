class EventsController < ApplicationController
  def index
    @events = Kaminari.paginate_array(Event.order(:time)).page(params[:page]).per(DEFAULT_PAGE_LENGTH)
  end
end
