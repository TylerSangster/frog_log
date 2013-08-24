class ResourcesController < ApplicationController

  before_action :require_signed_in,        only: [:new]

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
      flash[:error] = "Whoops! You've made an error while creating a resource."
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
      flash[:error] = "Please check the errors in your update"
      render 'edit'
    end
  end

  def index
    if params[:subject_list]
      @resources = Resource.tagged_with(params[:subject_list])
    elsif params[:format_list]
      @resources = Resource.tagged_with(params[:format_list])
    elsif params[:provider_list]
      @resources = Resource.tagged_with(params[:provider_list])
    else
      @resources = Resource.all
    end
      @resources = @resources.paginate(:page => params[:page], :per_page => 10)
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

  private

  def resource_params
    params.require(:resource).permit(:name, :subject_list, :format_list, :provider_list, :description, :cost, :cost_type, :provider_list, :url, :resource_photo, :remove_resource_photo, :subject, :format, :provider)
  end
end
