class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :access_right_check, except: [:index, :show]

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

  def buy
    # unless @item.soldout
      card = CreditCard.where(user_id: current_user.id)
      if card.exists?
        @card     = CreditCard.find_by(user_id: current_user.id)
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @default_card_information = Payjp::Customer.retrieve(@card.customer_id).cards.data[0]
      end
    # else
    #   redirect_to product_path(@product)
    # end
  end

  private

  # def access_right_check
  #   item = Item.find(params[:id])
  #   unless current_user&.id == item.user_id
  #     flash[:alert] = "権限がありません"
  #     redirect_back(fallback_location: item_path(item))
  #   end
  # end
end
