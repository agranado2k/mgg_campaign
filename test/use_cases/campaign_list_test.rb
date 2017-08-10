require_relative "../simple_test_helper"
require_relative "../../app/use_cases/campaign_list"
require_relative "../../app/entities/campaign"

class CampaignInMemoryRepo
  def initialize
    @db = {}
    @counter = 0
  end

  def new_entity(attrs)
    object = Entities::Campaign.new(attrs)
    @counter += 1
    object.id ||= @counter
    @db[object.id] = object
    true
  end

  def all
    @db.values
  end
end

class CampaignListTest < Minitest::Test
  def setup
    repo = CampaignInMemoryRepo.new
    repo.new_entity(name: "ssss_uk_01B")
    repo.new_entity(name: "Emmerdale")
    repo.new_entity(name: "ssss_uk_zzactions")
    @use_case_campaign_list = UseCases::CampaignList.new(repo)
  end

  def test_list_campaigns_names
    name_list = ["ssss_uk_01B","Emmerdale", "ssss_uk_zzactions"]

    assert_equal name_list, @use_case_campaign_list.list_names
  end
end
