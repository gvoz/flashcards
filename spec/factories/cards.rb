FactoryGirl.define do
  factory :card do
    user
    deck
    original_text "hause"
    translated_text "house"
    review_date -15.days.from_now
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'images', 'images.jpeg')) }
    review_interval 7.0
    number_of_mistakes 3
  end
end
