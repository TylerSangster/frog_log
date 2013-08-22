class ReviewsController < ApplicationController
  before_action :require_current_user,    except: [:index, :show]
  
  def new
    @review = Review.new
  end

  def create
    @review = @current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to root_url
    else render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_url
    flash[:success] = "Review deleted!"
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
    if @review.user != @current_user
      redirect_to root_path, :error => "You cannot edit somebody else's review." 
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "Your review was updated"
      redirect_to @review
    else
      render 'edit'
    end
  end
  private

    def review_params
      params.require(:review).permit(:title, :score, :content, :resource_photo, :remove_resource_photo)
    end
end
