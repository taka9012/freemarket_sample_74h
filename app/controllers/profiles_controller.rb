class ProfilesController < ApplicationController
  before_action :set_user

  def new
      @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.create(profile_params)
    redirect_to user_path(@user)
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
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
