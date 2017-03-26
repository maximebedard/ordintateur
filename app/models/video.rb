class Video < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :titre, :description, :video_url, presence: true

  def public_url
    ""
  end

  def views_count
    # shitty but works
    Ordinateur.redis.increment("views:#{@video.id}:#{current_user.id}")
  end
end
