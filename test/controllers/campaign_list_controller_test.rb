require 'test_helper'

class CampaignListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get campaign_list_index_url
    #assert_response :success
  end

end
