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
  end

  def update
  end

end
