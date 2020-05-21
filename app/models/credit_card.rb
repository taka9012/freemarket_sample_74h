class CreditCard < ApplicationRecord
  belongs_to :user

  Payjp.api_key = Rails.application.credentials.payjp'PAYJP_PRIVATE_KEY'
  #リトライ回数の制御に使用
  try = 0
  begin
   #実行のたびにカウントアップ（リトライ数をカウントする）
   try += 1
   #例外を捕捉したい処理。参考として顧客情報の参照APIを拝借
  #  @customer = Payjp::Customer.retrieve(current_user.card.customer_id)
  rescue Payjp::CardError => e
    body = e.json_body
    @message = "このカードはご利用になれません。エラーコードを添えてお問い合わせください。 エラーコード:[#{body[:error][:code]}]"
  rescue Payjp::InvalidRequestError => e
    body = e.json_body
    @message = "入力いただいた情報に誤りがあります。今一度ご確認をお願いします。[対象項目：#{body[:error][:param]}]"
    logger.error body[:error][:message]
  rescue Payjp::AuthenticationError => e
    @message = "システムエラーが発生しております。エラーコードを添えてお問い合わせください。[ステータス：#{e.http_status}]"
  rescue Payjp::APIConnectionError => e
    #ネットワーク障害なら復活するかもってことで数回リトライしてみる
    if try < 5
      logger.error "APIConnectionErroによりリトライが発生しています。リトライ回数#{try}"
      sleep(5)
      retry
    end
    #諦めるしかない。諦めよう。タイムアウトとかのエラーはレスポンス無いので汎用メッセージ。
    @message = "システムエラーが発生しております。窓口までお問い合わせください。"
  rescue Payjp::APIError => e
    # エラーの発生方法が不明のため省略
  # ensure
  #   # クレジットカード情報取得は成否に関わらず同じ画面表示想定としてコチラに書いてみる
  #   # 正直Payjpでの使いどころが分からない。
  #   render :action
  end
end
