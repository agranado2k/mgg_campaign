module Repositories
  class InMemoryRepoBase
    def initialize
      @db = {}
      @counter = 0
    end

    def new_entity(attrs)
      object = model_class.new(attrs)
      @counter += 1
      object.id ||= @counter
      @db[object.id] = object
      object
    end

    def all
      @db.values
    end

    def wrap_model(domains)
      @db.values
    end
  end
end
