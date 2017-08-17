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

    def find_by(args)
      all.select{|v| v.name == args[:name]}.first
    end
  end
end
