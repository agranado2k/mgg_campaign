module UseCases
  class UseCaseBase
    attr_reader :repo

    def repo_register
      @repo = Repositories::Repository
    end
  end
end
