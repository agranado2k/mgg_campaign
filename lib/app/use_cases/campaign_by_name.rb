module UseCases
  class CampaignByName < UseCaseBase
    def find_by(name)
      repo_register.for(:campaign).find_by(name: name)
    end
  end
end
