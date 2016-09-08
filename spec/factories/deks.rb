FactoryGirl.define do
  factory :deck do
    user
    name "deck"
    description "test deck"
    current true
  end
end
