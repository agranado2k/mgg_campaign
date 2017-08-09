require_relative "../simple_test_helper"
require_relative "../../app/use_cases/migrate_campaign_data"


module MigrateCampaignDataTest

  class ProcessDataTest < Minitest::Test
    def setup
      @migrate_campaign = UseCases::MigrateCampaignData.new
    end

    def test_convert_data_line_to_hash
      line = "VOTE 1168042591 Campaign:ssss_uk_01B Validity:during Choice:Jane CONN:MIG01TU MSISDN:00777779489999 GUID:190E96A8-89CA-41F8-9611-91F3490ACCA4 Shortcode:63334"
      hash = {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}

      assert_equal hash, @migrate_campaign.convert_line_to_hash(line)
    end

    def test_create_pre_structure_with_data
      lines = [
        "VOTE 1168042591 Campaign:ssss_uk_01B Validity:during Choice:Jane CONN:MIG01TU MSISDN:00777779489999 GUID:190E96A8-89CA-41F8-9611-91F3490ACCA4 Shortcode:63334",
        "VOTE 1168042606 Campaign:ssss_uk_01B Validity:during Choice:Tupele CONN:MIG01TU MSISDN:00777773559999 GUID:A375C7FE-B748-480B-B8D4-5CE86A79762B Shortcode:63334",
        "VOTE 1168042652 Campaign:Emmerdale Validity:during Choice:GRAYSON CONN:MIG01OU MSISDN:00777771739999 GUID:36E30841-0B9A-47FF-9A13-AA97A27A2E18 Shortcode:63339"
      ]

      pre_structure = {
        "ssss_uk_01B" => [
          {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334},
          {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Tupele", CONN: "MIG01TU", MSISDN: "00777773559999", GUID: "A375C7FE-B748-480B-B8D4-5CE86A79762B", Shortcode: 63334}
        ],
        "Emmerdale" => [
          {Campaign: "Emmerdale", Validity: "during", Choice: "GRAYSON", CONN: "MIG01OU", MSISDN: "00777771739999", GUID: "36E30841-0B9A-47FF-9A13-AA97A27A2E18", Shortcode: 63339}
        ]
      }

      assert_equal pre_structure, @migrate_campaign.create_pre_structure(lines)
    end
  end

  class ValidateDataTest < Minitest::Test
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
