FactoryBot.define do
  factory :credit_card do
    id                  {1}
    user_id             {1}
    card_id             {"test_id"}
    customer_id         {"test_id"}
  end
end