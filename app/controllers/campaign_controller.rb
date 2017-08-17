class CampaignController < ApplicationController
  def index
    @names = UseCases::CampaignList.new.list_names
  end

  def detail
    name = params[:id]
    campaign = UseCases::CampaignByName.new.find_by(name)
    @details = UseCases::CampaignDetails.new.detail(campaign).sort{|e| e[:valid_votes]}.reverse
  end
end
