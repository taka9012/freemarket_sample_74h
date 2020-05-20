class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :access_right_check, except: [:index, :show, :new, :create]

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
    item = Item.find(params[:id])
    if item.destroy
      flash[:notice] = "削除が完了しました"
      redirect_to root_path
    else 
      render :show
    end
  end

  private

  def access_right_check
    item = Item.find(params[:id])
    unless current_user&.id == item.user_id
      flash[:alert] = "権限がありません"
      redirect_back(fallback_location: item_path(item))
    end
  end
end
