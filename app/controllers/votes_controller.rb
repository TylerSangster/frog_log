class VotesController < ApplicationController
  before_action :set_current_user 

  def create
    @current_user.vote!(params[:vote][:review_id], params[:vote][:kind])
    @review = Review.find(params[:vote][:review_id])
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end
end
