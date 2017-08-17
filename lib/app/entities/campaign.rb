module Entities
  class Campaign < EntityBase
    attr_accessor :id, :name, :votes

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @votes = args[:votes] || []
    end
  end
end
