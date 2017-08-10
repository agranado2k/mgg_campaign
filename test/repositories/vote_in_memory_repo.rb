require_relative "./in_memory_repo_base"

module Repositories
  class VoteInMemoryRepo < InMemoryRepoBase
    def model_class
      Entities::Vote
    end
  end
end
