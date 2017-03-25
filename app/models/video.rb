class Video < ApplicationRecord
  validates :titre, :description, :url, presence: true
end
