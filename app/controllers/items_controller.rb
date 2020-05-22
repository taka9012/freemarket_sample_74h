class ItemsController < ApplicationController
  protect_from_forgery except: :search
  before_action :set_item, except: [:index, :new, :create, :done]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :access_right_check, except: [:index, :show, :new, :create, :buy, :pay, :done]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(8)
  end
  
  def new
    @item = Item.new
    @image = @item.images.new
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

  def buy
      card = CreditCard.where(user_id: current_user.id)
      if card.exists?
        @card     = CreditCard.find_by(user_id: current_user.id)
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @default_card_information = Payjp::Customer.retrieve(@card.customer_id).cards.data[0]
      end
  end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
    @item.update(trading_status_id:"2") 
  redirect_to done_items_path(@item.id) #完了画面に移動
  end

  def done
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :category, :item_status_id, :postage_type_id,
    :postage_burden_id, :shipping_area, :shipping_date_id, :trading_status_id, images_attributes: [:src, :_destroy, :id],
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
