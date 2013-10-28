class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.published.order(name: :asc).page(params[:page]).per(DEFAULT_PAGE_LENGTH)
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
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.published.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(
        :name,
        :synopsis,
        :website,
        :email,
        :phone,
        :submitter_name,
        :submitter_email,
        :submitter_phone,
        {:contacts_attributes => [:id, :name, :title, :email, :_destroy]}
      )
    end
end
