class EventsController < ApplicationController
  def index
    @events = Kaminari.paginate_array(Event.order(:time)).page(params[:page]).per(20)
  end
end
