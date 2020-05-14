FactoryBot.define do

  factory :address do
    firstname             {"フリマ"}
    lastname              {"太郎"}
    firstname_kana        {"フリマ"}
    lastname_kana         {"タロウ"}
    postal_code           {1340022}
    prefectures           {"東京都"}
    city                  {"渋谷区"}
    house_number          {"道玄坂4-5-6"}
    building_name         {"フォンティスビル7階"}
    telephone_number      {"07055553333"}
    user_id               {5}
  end
end