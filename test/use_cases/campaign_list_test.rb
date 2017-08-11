require_relative "../simple_test_helper"

class CampaignListTest < Minitest::Test
  def setup
    Repositories::Repository.register(:campaign, Repositories::CampaignInMemoryRepo.new)
    Repositories::Repository.register(:vote, Repositories::VoteInMemoryRepo.new)
    Repositories::Repository.for(:campaign).new_entity(name: "ssss_uk_01B")
    Repositories::Repository.for(:campaign).new_entity(name: "Emmerdale")
    Repositories::Repository.for(:campaign).new_entity(name: "ssss_uk_zzactions")

    @use_case_campaign_list = UseCases::CampaignList.new
  end

  def test_list_campaigns_names
    name_list = ["ssss_uk_01B","Emmerdale", "ssss_uk_zzactions"]

    assert_equal name_list, @use_case_campaign_list.list_names
  end
end
