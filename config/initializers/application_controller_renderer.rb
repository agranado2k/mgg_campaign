# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )

if Rails.env == "test"
  require_dependency "../../app/repositories/repository"
  require_dependency "../../test/repositories/campaign_in_memory_repo"
  require_dependency "../../test/repositories/vote_in_memory_repo"
  Repositories::Repository.register(:campaign, Repositories::CampaignInMemoryRepo.new)
  Repositories::Repository.register(:vote, Repositories::VoteInMemoryRepo.new)
end
