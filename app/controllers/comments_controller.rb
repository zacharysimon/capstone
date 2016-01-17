class CommentsController < ApplicationController

  def create
    comment = Comment.create(
      user_id: current_user.id,
      listing_id: params[:input_listing_id],
      comment: params[:input_comment],
      comment_type: params[:input_comment_type],
      score: params[:input_score]
      )

    redirect_to "/listings/#{comment.listing_id}"
  end

  def edit
    @listing = Listing.find_by(id: params[:id])
    @comments = Comment.find_by(listing_id: params[:id])
  end

  def update
    comment = Comment.find_by(id: params[:id])
    @listing = Listing.find_by(id: comment.listing_id)
    p comment
    p @listings

    comment.update(
      score: params[:input_score],
      comment: params[:input_comment],
      comment_type: params[:input_comment_type],
      )

    redirect_to "/listings"
  end

end
