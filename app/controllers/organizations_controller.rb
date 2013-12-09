class OrganizationsController < ApplicationController
  load_and_authorize_resource class: Organization, instance_name: :organization, except: [:create, :update]
  before_filter :load_resource, only: [:update]
  before_filter :new_organization, only: [:new, :create]

  # GET /organizations
  # GET /organizations.json
  def index
    get_by_published_status(true)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @organization.contacts.build
  end

  # GET /organizations/1/edit
  def edit

  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    respond_to do |format|
      if @organization.save
        current_user.add_role :editor, @organization
        format.html { redirect_to organizations_path, notice: 'Thank you for your submission. It will be published once it is reviewed by the staff.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: "Organization was destroyed." }
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


private

  def change_published_status(new_status)
    @organization = Organization.find(params[:id])
    if new_status
      @organization.publish!
      flash[:notice] = "Organization published."
    else
      @organization.unpublish!
      flash[:notice] = "Organization unpublished."
    end

    redirect_to organizations_path
  end

  def get_by_published_status(status)
    which_organizations = status ? Organization.published : Organization.unpublished
    @organizations = Kaminari.paginate_array(which_organizations.order(:created_at))
    @organizations = @organizations.page(params[:page]).per(DEFAULT_PAGE_LENGTH)
    @organization_json = @organizations.map do |organization|
      {
        title: organization.name,
        start: organization.created_at.strftime("%Y-%m-%d")
      }
    end.to_json

    render "index"
  end

  def load_resource
    @organization = Organization.find(params[:id])
  end

  def new_organization
    @organization = Organization.new(params[:organization] ? organization_params : nil)
  end

  def organization_params
    if params[:organization][:feeds]
      params[:organization][:feed_attributes] = params[:organization][:feeds]
      params[:organization].delete(:feeds)
    end

    params.require(:organization).permit(
      { feed_attributes: [ :uri ] },
      :name,
      :synopsis,
      :website,
      :email,
      :phone,
      :submitter_name,
      :submitter_email,
      :submitter_phone,
      { contacts_attributes: [:id, :name, :title, :email, :_destroy] }
    )
  end
end
