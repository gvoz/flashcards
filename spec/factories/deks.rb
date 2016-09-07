FactoryGirl.define do
  factory :deck do
    association(:user)
    name "deck"
    description "test deck"
    current true
  end
end
