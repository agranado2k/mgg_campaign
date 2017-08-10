module Entities
  class Campaign
    attr_accessor :id, :name, :votes

    def initialize(args)
      @name = args[:name]
      @votes = args[:votes] || []
    end
  end
end
