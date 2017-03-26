class Video < ApplicationRecord
  has_many :comments
  validates :titre, :description, :video_url, presence: true
end
