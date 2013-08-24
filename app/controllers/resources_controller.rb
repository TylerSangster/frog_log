class ResourcesController < ApplicationController

  before_action :require_signed_in,        only: [:new]

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      # session[:resource_id] = @resource.resource_id
      flash[:success] = "Thank you for submitting the resource, #{current_user.first_name.capitalize}!"      
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
    if params[:subject]
      @resources = Resource.tagged_with(params[:subject])
    elsif params[:format]
      @resources = Resource.tagged_with(params[:format])
    elsif params[:provider]
      @resources = Resource.tagged_with(params[:provider])
    else
      @resources = Resource.all
    end
      
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
    params.require(:resource).permit(:name, :subject_list, :format_list, :description, :cost, :cost_type, :provider_list, :url, :resource_photo, :remove_resource_photo)
  end
end
