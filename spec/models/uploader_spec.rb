require "rails_helper"

feature "Uploader" do
  include CarrierWave::Test::Matchers

  before :all do
    CardUploader.enable_processing = true
    CardUploader.storage :file
  end

  after :all do
    CardUploader.enable_processing = false
  end

  it "resize upload image" do
    uploader = CardUploader.new()
    uploader.store!(File.open("#{Rails.root}/spec/images/images.jpeg"))
    expect(uploader).to be_no_larger_than(360, 360)
  end
end
