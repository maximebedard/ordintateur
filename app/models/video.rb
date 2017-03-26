class Video < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :titre, :description, :video_url, presence: true

  def public_url
    ""
  end

  def view_count
    @view_count ||= Ordinateur.redis.hgetall("views:#{id}").sum
  end

  def increment_view_count(current_user)
    Ordinateur.redis.incr("views:#{id}:#{current_user.id}")
  end
end
