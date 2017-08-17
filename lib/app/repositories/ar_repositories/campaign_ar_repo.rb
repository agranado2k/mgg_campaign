module Repositories
  module ARRepositories
    class CampaignARRepo < ARRepoBase
      def new_entity(attrs)
        object = domain_class.new(attrs)
        model_attr = object.attributes
        model_attr[:vote_ars] = model_attr[:votes].map{|vote| VoteAr.new(vote.attributes)}
        model_attr.delete(:votes)
        model_object = super(model_attr)
        object.id ||= model_object.id
        object
      end

      def domain_class
        Entities::Campaign
      end

      def model_class
        CampaignAr
      end
    end
  end
end
