class ItemsController < ApplicationController
  protect_from_forgery except: :search
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
  end
  
  def new
    @item = Item.new
    @image = @item.images.new
  end

  def create
    @item = Item.new(item_params)
   
    if @item.save
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

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :item_status_id, :postage_type_id,
    :postage_burden_id, :shipping_area_id, :shipping_date_id, :trading_status_id, images_attributes: [:src, :_destroy, :id],
     brand_attributes: [:name])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_images
    @images = Image.where(item_id: params[:id])
  end
  
end
