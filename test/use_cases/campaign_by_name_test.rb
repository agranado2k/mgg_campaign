require "test_helper"

class CampaignByNameTest < Minitest::Test
  def setup
    Repositories::Repository.register(:campaign, Repositories::CampaignInMemoryRepo.new)
    @campaign = Repositories::Repository.for(:campaign).new_entity({name: "ssss_uk_01B"})

    @campaign_by_name = UseCases::CampaignByName.new
  end

  def test_campagin_detail
    assert_equal @campaign.name, @campaign_by_name.find_by("ssss_uk_01B").name
  end
end
