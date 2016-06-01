module Betaface
  module Util
    class ClientConfig
      DEFAULTS = {
          host: 'https://www.betafaceapi.com/',
          port: 443,
          use_ssl: true,
          timeout: 30,
          retry_limit: 1
      }

      DEFAULTS.each_key do |attribute|
        attr_accessor attribute
      end

      def initialize(opts={})
        DEFAULTS.each do |attribute, value|
          send("#{attribute}=".to_sym, opts.fetch(attribute, value))
        end
      end
    end
  end
end
