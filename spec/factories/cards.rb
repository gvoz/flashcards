FactoryGirl.define do
  factory :card do
    association(:deck)
    original_text "hause"
    translated_text "house"
    review_date -15.days.from_now
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'images', 'images.jpeg')) }
  end
end
