class ItemsController < ApplicationController
  before_action :access_right_check, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end
  
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
  end

  private

  def access_right_check
    item = Item.find(params[:id])
    unless user_signed_in? || (user_signed_in? && current_user.id == item.user_id)
      flash[:alert] = "権限がありません"
      redirect_back(fallback_location: item_path(item))
    end
  end

end
