class VideosController < ApplicationController
  def index
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.save

    respond_with(@video)
  end

  def update
    @video = Video.find(params[:id])
    @video.assign_attributes(video_params)
    @video.save

    respond_with(@video)
  end

  def delete
    @video = Video.delete(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:titre, :description)
  end
end
