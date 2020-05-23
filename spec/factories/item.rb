FactoryBot.define do
 
  #　画像がある場合
    factory :item do
      name                  {"テスト商品"}
      explanation           {"最高級です！"}
      price                 {23000}
      item_status_id        {"2"}
      postage_type_id       {"1"}
      postage_burden_id     {"1"}
      shipping_area         {"東京都"}
      shipping_date_id      {"1"}
      trading_status_id     {"1"}
      association :category, factory: :category
      association :user, factory: :user
      association :brand, factory: :brand
      after(:build) do |item|
        item.images << build(:image, item: item)
      end
    end

  # 画像がない場合
    factory :item_no_picture, class: Item do
      name                  {"テスト商品"}
      explanation           {"最高級です！"}
      price                 {23000}
      item_status_id        {"2"}
      postage_type_id       {"1"}
      postage_burden_id     {"1"}
      shipping_area         {"東京都"}
      shipping_date_id      {"1"}
      trading_status_id     {"1"}
      association :category, factory: :category
      association :user, factory: :user
      association :brand, factory: :brand
    end
  end
  
  