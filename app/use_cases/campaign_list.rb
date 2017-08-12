require_dependency "./use_case_base"

module UseCases
  class CampaignList < UseCases::UseCaseBase
    def list_names
      repo_register.for(:campaign).all.map{|entity| entity.name}
    end
  end
end
