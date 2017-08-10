module UseCases
  class CampaignList < UseCaseBase
    def list_names
      repo_register.for(:campaign).all.map{|entity| entity.name}
    end
  end
end
