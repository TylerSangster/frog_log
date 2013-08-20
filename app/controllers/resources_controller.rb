class ResourcesController < ApplicationController
  before_action :require_current_user,    only: [:new]
  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      # session[:resource_id] = @resource.resource_id
      flash[:success] = "Thank you for submitting the resource, #{@resource.name.capitalize}!"      
      redirect_to @resource
    else
      flash[:error] = "Whoops! You've made an error while creating a resource."
      render action: :new
    end
  end

  def show
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
  end

  private

  def resource_params
      params.require(:resource).permit(:name, :subject, :format, :description, :cost, :cost_type, :provider, :url)
  end
end
