class EventsController < ApplicationController
  def import
    if request.post?
      count = Event.count
      Feed.all.each(&:import_events!)
      flash[:notice] = "#{Event.count - count} events imported."

      redirect_to unpublished_events_path
    end
  end

  def index
    get_by_published_status(true)
  end

  def publish
    change_published_status(true)
  end

  def published
    get_by_published_status(true)
  end

  def unpublish
    change_published_status(false)
  end

  def unpublished
    get_by_published_status(false)
  end


private

  def change_published_status(new_status)
    @event = Event.find(params[:id])
    if new_status
      @event.unpublish!
      flash[:notice] = "Event published."
    else
      @event.unpublish!
      flash[:notice] = "Event unpublished."
    end

    redirect_to events_path
  end

  def get_by_published_status(status)
    which_events = status ? Event.published : Event.unpublished
    @events = Kaminari.paginate_array(which_events.order(:dtstart))
    @events = @events.page(params[:page]).per(DEFAULT_PAGE_LENGTH)

    render "index"
  end

end
