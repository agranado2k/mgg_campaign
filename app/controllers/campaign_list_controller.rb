class CampaignListController < ApplicationController
  def index
    @names = UseCases::CampaignList.new.list_names
  end
end
