module Betaface
  module Util
    def url_encode(hash)
      hash.to_a.map {|p| p.map {|e| CGI.escape get_string(e)}.join '='}.join '&'
    end
  end
end
