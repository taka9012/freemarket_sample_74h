class ItemsController < ApplicationController
  protect_from_forgery except: :search
  before_action :set_item, except: [:index, :new, :create, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :access_right_check, except: [:index, :show, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end
  
  def new
    @item = Item.new
    @image = @item.images.new
  end

  def create
    @item = Item.new(item_params)
   
    if @item.valid?
      @item.save
      redirect_to root_path
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
    @item.destroy
    redirect_to root_path
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :category, :item_status_id, :postage_type_id,
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
