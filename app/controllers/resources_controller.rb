class ResourcesController < ApplicationController

  before_action :require_signed_in,    only: [:new]
  #before_action :require_admin_user    only: [:pending]
  
  respond_to :html, :json, :xml, except: [:new]

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      # session[:resource_id] = @resource.resource_id
      flash[:success] = "Thank you for submitting the resource!"      
      redirect_to @resource
    else
      flash[:danger] = "Whoops! You've made an error while creating a resource."
      render action: :new
    end
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      flash[:success] = "Your resource was updated"
      redirect_to @resource
    else
      flash[:danger] = "Please check the errors in your update"
      render 'edit'
    end
  end

  def index
    @resources = Resource.where(status: true)
    @resources = @resources.tagged_with(params[:tag]) if params[:tag]
    @resources = @resources.paginate(:page => params[:page], :per_page => 10)

    respond_with @resources
  end
  
  def destroy
    @resource_to_delete = Resource.find(params[:id])
      @resource_to_delete.destroy
      flash[:success] = "Resource destroyed."
      redirect_to resources_url
  end

  def interested
    @resource = Resource.find(params[:id])
  end

  def search
    @results = Resource.where(status: true).search_for(params[:query]).paginate(:page => params[:page], :per_page => 10)
    respond_with @results
  end

  def pending
    @resources = Resource.where(status: false).paginate(:page => params[:page], :per_page => 10)
  end

  def status
    @resource = Resource.where(status: false).find(params[:id])
    if @resource.status
      @resource.status = false
    else
      @resource.status = true
    end
    @resource.save
    redirect_to pending_resources_path
  end

  def import
    Resource.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end


  private

  def resource_params
    params.require(:resource).permit(:name, :subject_list, :format_list, :provider_list, :description, :cost, :cost_type, :provider_list, :url, :resource_photo, :remove_resource_photo, :status, :query)
  end
end
