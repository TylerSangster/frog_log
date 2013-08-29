class ReviewsController < ApplicationController
  before_action :require_signed_in,    except: [:index, :show]
  
  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to resource_path(@review.resource_id)
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
    if @review.user != current_user
      redirect_to root_path, :danger => "You cannot edit somebody else's review." 
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "Your review was updated"
      redirect_to resource_path(@review.resource_id)
    else
      render 'edit'
    end
  end
  private

    def review_params
      params.require(:review).permit(:title, :score, :content, :resource_id)
    end
end
