require 'test_helper'

class FlashCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flash_cards_index_url
    assert_response :success
  end

end
