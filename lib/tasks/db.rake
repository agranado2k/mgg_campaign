alias require_dependency require_relative
require_dependency "../../lib/app/use_cases/migrate_campaign_data"

namespace :db do
  desc "Migrate campaigns data from file to local db"
  task :migrate_campaigns_data, [:file_name] => [:environment] do |t, args|
    file_name = args[:file_name]
    UseCases::MigrateCampaignData.new.migrate(file_name)
  end
end
