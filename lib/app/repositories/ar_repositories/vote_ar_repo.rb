module Repositories
  module ARRepositories
    class VoteARRepo < ARRepoBase
      def new_entity(attrs)
        object = domain_class.new(attrs)
        model_attr = object.attributes
        model_object = super(model_attr)
        object.id ||= model_object.id
        object
      end

      def domain_class
        Entities::Vote
      end

      def model_class
        VoteAr
      end
    end
  end
end
