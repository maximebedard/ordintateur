class VideosController < ApplicationController
  respond_to :html, :json, :js
  def index
    @videos = Video.order(created_at: :desc)
  end

  def show
    @video = Video.find(params[:id])
    @video.increment_view_count(current_user)
    @liked = false
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
    @liked = false
  end

  def add_comment
    @video = Video.find(params[:video_id])

    video_comment_params = params.require(:comment).permit(:description, :seconds_from_start)

    @comment = Comment.new(video_comment_params)
    @comment.video = @video
    @comment.user = current_user
    @comment.save

    respond_with(@comment)
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
    @q = params[:q]

    respond_to do |format|
      format.html
      format.json {
        render json: Video.all.to_json(methods: [:duration, :thumbnail, :public_url])
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
    destination_path = "#{destination_dir}/#{uploaded_io.original_filename}"
    ext = File.extname(uploaded_io.original_filename)

    File.open(destination_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    # Thumbnail
    `convert #{destination_path}[0] #{destination_dir}/thumb.jpg`


    destination_path
  end
end
