class FeedsController < ApplicationController
  load_and_authorize_resource class: Feed, instance_name: :feed, except: [:create, :update]
  before_filter :load_resource, only: [:update]
  before_filter :new_feed, only: [:new, :create]

  # GET /feeds
  # GET /feeds.json
  def index
    get_by_published_status(true, page_length: nil) # Show all events.
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit

  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to feeds_path, notice: "Feed created." }
        format.json { render action: 'show', status: :created, location: @feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was destroyed." }
      format.json { head :no_content }
    end
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

  def special
    @feeds = Kaminari.paginate_array(Feed.special.order(:created_at))
    @feeds = @feeds.page(params[:page]).per(DEFAULT_PAGE_LENGTH)

    render "index"
  end


private

  def change_published_status(new_status)
    @feed = Feed.find(params[:id])
    if new_status
      @feed.publish!
      flash[:notice] = "Feed published."
    else
      @feed.unpublish!
      flash[:notice] = "Feed unpublished."
    end

    redirect_to feeds_path
  end

  def get_by_published_status(status, options={})
    options[:page_length] = DEFAULT_PAGE_LENGTH unless options.keys.index(:page_length)
    which_feeds = status ? Feed.published : Feed.unpublished
    @feeds = which_feeds.order(:dtstart)
    if options[:page_length]
      @feeds = Kaminari.paginate_array(feeds)
      @feeds = @feeds.page(params[:page]).per(DEFAULT_PAGE_LENGTH)
    end

    render "index"
  end

  def load_resource
    @feed = Feed.find(params[:id])
  end

  def new_feed
    @feed = Feed.new(params[:feed] ? feed_params : nil)
  end

  def feed_params
    if params[:feed][:feeds]
      params[:feed][:feed_attributes] = params[:feed][:feeds]
      params[:feed].delete(:feeds)
    end

    params.require(:feed).permit(:uri)
  end

end
