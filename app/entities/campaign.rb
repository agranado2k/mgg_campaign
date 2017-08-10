module Entities
  class Campaign
    attr_reader :name
    attr_accessor :votes

    def initialize(name)
      @name = name
      @votes = []
    end
  end
end
