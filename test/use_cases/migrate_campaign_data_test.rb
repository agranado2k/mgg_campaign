require_relative "../simple_test_helper"
require_relative "../../app/use_cases/migrate_campaign_data"


module MigrateCampaignDataTest

  class ValidateTest < Minitest::Test
    def setup
      @migrate_campaign = UseCases::MigrateCampaignData.new
    end

    def test_identify_valid_line
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      assert @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_campagin_field
      data = "VOTE 1168041980 Validity:during Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      refute @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_validity_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      refute @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_choice_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      refute@migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_conn_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      refute @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_msisdn_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG00VU GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334"

      refute @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_guid_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 Shortcode:63334"

      refute @migrate_campaign.valid?(data)
    end

    def test_identify_invalid_line_miss_shortcode_field
      data = "VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG00VU MSISDN:00777778429999 GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19"

      refute @migrate_campaign.valid?(data)
    end
  end
end
