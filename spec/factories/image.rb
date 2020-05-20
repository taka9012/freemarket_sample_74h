FactoryBot.define do
  factory :image do
    src       {File.open("#{Rails.root}/app/assets/images/simple.jpg")} #テスト画像はassetにあるやつを適当に指定
    association  :item, factory: :item
  end
end

