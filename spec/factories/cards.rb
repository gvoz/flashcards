FactoryGirl.define do
  factory :card do
    association(:user)
    original_text "hause"
    translated_text "house"
    review_date -15.days.from_now
  end
end