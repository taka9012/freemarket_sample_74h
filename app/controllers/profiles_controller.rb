class ProfilesController < ApplicationController
  before_action :set_user

  def index
    @profile = Profile.new
  end

  def create
    @profile
    redirect_to user_path(@user)
  end

  private
  def profile_params
    params.require(:profile).permit(:profile_sentence, :icon_image).merge(user_id: current_user.id)
  end


  def set_user
    @user = current_user
  end


end
