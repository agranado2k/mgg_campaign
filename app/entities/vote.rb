module Entities
  class Vote
    attr_accessor :id, :validity, :choice, :conn, :msisdn, :guid, :short_code
    def initialize(args)
      @validity = args[:Validity]
      @choice = args[:Choice]
      @conn = args[:CONN]
      @msisdn = args[:MSISDN]
      @guid = args[:GUID]
      @short_code = args[:Shortcode]
    end
  end
end
