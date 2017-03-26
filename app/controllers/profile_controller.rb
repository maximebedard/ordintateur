class ProfileController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    @user.save

    render :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :description, :avatar)
  end
end
