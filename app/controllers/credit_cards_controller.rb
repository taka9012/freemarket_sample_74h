class CreditCardsController < ApplicationController

  require 'payjp'
  def new
    # クレジットカード登録画面にてマイページへのリンクを貼る
    @user = current_user
    # 現状以下のインスタンスを渡してあげないと、画面遷移しないため
    @profile = @user.profile
    @credit_card = CreditCard.new
    card = CreditCard.where(user_id: current_user.id)
    if card.exists?
      redirect_to credit_card_path(card[0].id)
    end
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: '登録テスト', #なくてもOK
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
        ) 
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to credit_card_path(@card.id)
        flash[:notice] = 'クレジットカードの登録が完了しました'
      else
        redirect_to action: "new"
        flash[:alert] = 'クレジットカード登録に失敗しました'
      end
    end
    
  end


  def show
    @user = current_user #マイページで@userの変数を用いているため、現状記述の必要あり
    @profile = @user.profile
    card = CreditCard.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "create"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
    end
  end

  def destroy #PayjpとCardデータベースを削除します
    card = CreditCard.where(user_id: current_user.id).first
    if card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_credit_card_path
  end
end
