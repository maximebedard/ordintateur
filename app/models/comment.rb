class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user_id, :description, presence: true
end
