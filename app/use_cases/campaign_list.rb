module UseCases
  class CampaignList
    attr_reader :repo

    def initialize(repo)
      @repo = repo
    end

    def list_names
      repo.all.map{|entity| entity.name}
    end
  end
end
