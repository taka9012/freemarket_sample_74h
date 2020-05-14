FactoryBot.define do

  factory :user do
    nickname              {"テストマン"}
    email                 {"kkk@gmail.com"}
    password              {"12345678"}
    password_confirmation {"12345678"}
    firstname             {"フリマ"}
    lastname              {"太郎"}
    firstname_kana        {"フリマ"}
    lastname_kana         {"タロウ"}
    birth_year            {1989}
    birth_month           {4}
    birth_day             {15}
  end
end