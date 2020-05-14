class CreditCardsController < ApplicationController

  def new
    # クレジットカード登録画面にてマイページへのリンクを貼るため
    @user = current_user
  end
end
