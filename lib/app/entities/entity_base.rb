module Entities
  class EntityBase
    def attributes
      instance_variables.reduce({}){|h, ivar| h.merge(ivar.to_s.gsub("@","").to_sym => instance_variable_get(ivar))}
    end
  end
end
