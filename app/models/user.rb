class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def avatar
    if super.nil? || super.empty?
      'https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg'
    else
      super
    end

  end
end
