module Entities
  class Vote < EntityBase
    attr_accessor :id, :campaign, :validity, :choice, :conn, :msisdn, :guid, :short_code

    def initialize(args)
      @id = args[:id]
      @campaign = args[:Campaign]
      @validity = args[:Validity]
      @choice = args[:Choice]
      @conn = args[:CONN]
      @msisdn = args[:MSISDN]
      @guid = args[:GUID]
      @short_code = args[:Shortcode]
    end
  end
end
