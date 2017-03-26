class Video < ApplicationRecord
  has_many :comments
  belongs_to :user, optional: true
  validates :titre, :description, :video_url, presence: true

  def public_url
    video_url[/(\/uploads.*$)/]
  end

  def view_count
    @view_count ||= Ordinateur.redis.hgetall("views:#{id}").sum
  end

  def increment_view_count(current_user)
    Ordinateur.redis.incr("views:#{id}:#{current_user.id}")
  end

  def thumbnail
    public_url.gsub(/(\/[^\/]*)$/, '/thumb.jpg')
  end

  def duration
    begin
      hours, minutes, seconds = `ffmpeg -i #{video_url} 2>&1 | grep Duration`.split(/(, |: )/)[2].split(':').map(&:to_i)
      return hours * 3600 + minutes * 60 + seconds
    rescue
      return 0
    end
  end
end
