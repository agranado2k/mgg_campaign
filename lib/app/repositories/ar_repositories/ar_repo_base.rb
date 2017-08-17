module Repositories
  module ARRepositories
    class ARRepoBase
      def new_entity(attrs)
        model_object = model_class.new(attrs)
        model_object.save!
        model_object
      end
    end
  end
end
