class ItemsController < ApplicationController
  protect_from_forgery except: :search
  before_action :set_item, only: [:edit, :update, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :access_right_check, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(8)
  end
  
  def new
    @item = Item.new
    @image = @item.images.new
    @category_parent_array = ["選択してください"]
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品が完了しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path, notice:'削除が完了しました'
    else 
      render :show
    end
  end
  def show
  end

  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :category_id, :item_status_id, :postage_type_id,
    :postage_burden_id, :shipping_area_id, :shipping_date_id, :trading_status_id, images_attributes: [:src, :_destroy, :id],
     brand_attributes: [:name]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def access_right_check
    item = Item.find(params[:id])
    unless current_user&.id == item.user_id
      flash[:alert] = "権限がありません"
      redirect_back(fallback_location: item_path(item))
    end
  end

  def set_images
    @images = Image.where(item_id: params[:id])
  end

  
  
end
