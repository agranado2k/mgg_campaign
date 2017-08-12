require File.expand_path('../../config/environment', __FILE__)


alias require_dependency require_relative
require_relative "./repositories/campaign_in_memory_repo"
require_relative "./repositories/vote_in_memory_repo"
require_relative "../app/entities/campaign"
require_relative "../app/entities/vote"
require_relative "../app/use_cases/use_case_base"
require_relative "../app/use_cases/migrate_campaign_data"
require_relative "../app/use_cases/campaign_list"
require_relative "../app/use_cases/campaign_details"

require "minitest/autorun"

