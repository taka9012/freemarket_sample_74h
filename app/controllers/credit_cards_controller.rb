class CreditCardsController < ApplicationController

  def new
    # クレジットカード登録画面にてマイページへのリンクを貼る
    @user = current_user
    # 現状以下のインスタンスを渡してあげないと、画面遷移しないため
    @profile = @user.profile
  end
end
