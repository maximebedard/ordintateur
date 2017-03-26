class VideosController < ApplicationController
  respond_to :html, :json
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
    @video.video_url = upload_video(params[:video][:io]) if @video.valid?
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
    params.require(:video).permit(:titre, :description, :tags)
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
