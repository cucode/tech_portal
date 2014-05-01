class EventsController < ApplicationController
  load_and_authorize_resource class: Event, instance_name: :resource, except: [:create, :update]

  def import
    authorize! :import, :events unless has_valid_cron_token?
    if request.post?
      count = Event.count
      errors = []
      (Feed.published + Feed.special).each do |feed|
        begin
          logger.info "[events_controller.import] Importing feed #{feed.uri}..."
          feed.import_events!
          logger.info "[events_controller.import] Done."
        rescue Exception => ex
          logger.info "[events_controller.import] Exception: #{ex}."
          errors << ex
        end
      end
      flash[:notice] = "#{Event.count - count} events imported."
      unless errors.empty?
        flash[:error] = "Encountered the following errors during import: " + errors.map(&:to_s).join(", ")
      end

      redirect_to unpublished_events_path
    end
  end

  def index
    get_by_published_status(true, page_length: nil) # Show all events.
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /events/1/edit
  def edit

  end

  # POST /events
  # POST /events.json
  def create
    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: "Event was successfully created." }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @resource = Event.find(params[:id])
    respond_to do |format|
      if @resource.update_attributes(resource_params)
        format.html { redirect_to @resource, notice: "Event was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def blog
    @resources = Event.blogged
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

  def resource_params
    return nil unless params[:event]
    params.require(:event).permit(:blog_content, :event_photo, :event_photo_cache, :remove_event_photo)
  end

  def change_published_status(new_status)
    @event = Event.find(params[:id])
    if new_status
      @event.publish!
      flash[:notice] = "Event published."
    else
      @event.unpublish!
      flash[:notice] = "Event unpublished."
    end

    redirect_to events_path
  end

  def get_by_published_status(status, options={})
    options[:page_length] = DEFAULT_PAGE_LENGTH unless options.keys.index(:page_length)
    which_events = status ? Event.published : Event.unpublished
    @events = which_events.order(:dtstart)
    if options[:page_length]
      @events = Kaminari.paginate_array(@events)
      @events = @events.page(params[:page]).per(DEFAULT_PAGE_LENGTH)
    end

    @event_json = @events.map do |event|
      {
        description: event.description,
        start: event.dtstart.strftime("%Y-%m-%d"),
        title: event.summary,
        url: event.url
      }
    end.to_json

    render "index"
  end

end
