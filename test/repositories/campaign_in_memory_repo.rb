require_relative "./in_memory_repo_base"

module Repositories
  class CampaignInMemoryRepo < InMemoryRepoBase
    def model_class
      Entities::Campaign
    end
  end
end
