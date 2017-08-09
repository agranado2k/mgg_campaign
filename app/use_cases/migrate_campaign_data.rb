module UseCases
  class MigrateCampaignData
    DATA_PATTERN = 'VOTE\s+\d+\s+Campaign\:[\d\w\_]+\s+Validity\:\w+\s+Choice\:\w+\s+CONN:[\w\d]+\s+MSISDN\:\d+\s+GUID\:[\w\d\-]+\s+Shortcode\:\d+'
    CAMPAIGN_PATTERN = 'Campaign\:([\d\w\_]+)'
    VALIDITY_PATTERN = 'Validity\:(\w+)'
    CHOICE_PATTERN = 'Choice\:(\w+)'
    CONN_PATTERN = 'CONN:([\w\d]+)'
    MSISDN_PATTERN = 'MSISDN\:(\d+)'
    GUID_PATTERN = 'GUID\:([\w\d\-]+)'
    SHORT_CODE_PATTERN = 'Shortcode\:(\d+)'

    def create_pre_structure(lines)
      lines.reduce({}) do |r, line|
        hash = convert_line_to_hash(line)
        r[hash[:Campaign]] = [] if r[hash[:Campaign]].nil?
        r[hash[:Campaign]].push(hash)
        r
      end
    end

    def valid?(data)
      Regexp.new(DATA_PATTERN).match(data)
    end

    def convert_line_to_hash(line)
      campaign = Regexp.new(CAMPAIGN_PATTERN).match(line)[1]
      validity = Regexp.new(VALIDITY_PATTERN).match(line)[1]
      choice = Regexp.new(CHOICE_PATTERN).match(line)[1]
      conn = Regexp.new(CONN_PATTERN).match(line)[1]
      msisdn = Regexp.new(MSISDN_PATTERN).match(line)[1]
      guid = Regexp.new(GUID_PATTERN).match(line)[1]
      short_code = Regexp.new(SHORT_CODE_PATTERN).match(line)[1]

      {Campaign: campaign, Validity: validity, Choice: choice, CONN: conn, 
       MSISDN: msisdn, GUID: guid, Shortcode: short_code.to_i}
    end
  end
end
