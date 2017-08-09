module UseCases
  class MigrateCampaignData
    DATA_PATTERN = 'VOTE\s+\d+\s+Campaign\:[\d\w\_]+\s+Validity\:\w+\s+Choice\:\w+\s+CONN:[\w\d]+\s+MSISDN\:\d+\s+GUID\:[\w\d\-]+\s+Shortcode\:\d+'

    def valid?(data)
      Regexp.new(DATA_PATTERN).match(data)
    end
  end
end
