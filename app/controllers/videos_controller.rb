class VideosController < ApplicationController
  respond_to :html, :json
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
    @feedback = Ordinateur.redis.hget("likes:#{current_user.id}")
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new
    update_video
    respond_with(@video)
  end

  def like
    Ordinateur.redis.hset("likes:#{current_user.id}", !!params[:feedback])
  end

  def update
    @video = Video.find(params[:id])
    update_video

    respond_with(@video)
  end

  def delete
    @video = Video.delete(params[:id])
  end

  def search
    respond_to do |format|
      format.html
      format.json {
        render json: Video.all
      }
    end
  end

  private

  def update_video
    io = params[:video].delete(:io)
    tags = params[:video].delete(:tags)
    @video.assign_attributes(video_params)
    @video.video_url = upload_video(io)
    @video.user = current_user
    @video.tags = Array(tags.split(","))
    @video.save
  end

  def video_params
    params.require(:video).permit(:titre, :description, :io, :tags)
  end

  def upload_video(uploaded_io)
    destination_dir = FileUtils.mkdir_p("#{Rails.root}/public/uploads/#{SecureRandom.hex}").first
    destination_path = "#{destination_dir}/#{uploaded_io.original_filename.parameterize('_')}"

    File.open(destination_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    destination_path
  end
end
