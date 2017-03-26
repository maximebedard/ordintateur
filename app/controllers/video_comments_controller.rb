class VideoCommentsController < ApplicationController
  def create
    @comment = Comment.new(video_comment_params)
    @comment.video = video
    @comment.user = current_user
    @comment.save
  end

  private

  def video_comment_params
    params.require(:comment).permit(:description, :seconds_from_start)
  end

  def video
    @video ||= Video.find(params[:video_id])
  end
end
