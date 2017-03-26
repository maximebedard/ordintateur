class Video < ApplicationRecord
  validates :titre, :description, :video_url, presence: true
end
