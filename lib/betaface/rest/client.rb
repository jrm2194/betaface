module Betaface
  module REST
    class Client
      include Betaface::Util

      HTTP_HEADERS = {
          'Content-Type' => 'application/json',
          'Accept-Charset' => 'utf-8',
          'User-Agent' => "betaface/#{Betaface::VERSION}" \
                        " (#{RUBY_ENGINE}/#{RUBY_PLATFORM}" \
                        " #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})"
      }

      attr_reader :last_request, :last_response

      ##
      # Instantiate the Client with a key/secret if not set before
      # Just call new if Betaface.key and Betaface.secret have been init
      # Last argument is a hash of options
      def initialize(*args)
        @config = Betaface::Util::ClientConfig.new 
        @key = args[0] || Betaface.key
        @secret = args[1] || Betaface.secret
        if @key.nil? || @secret.nil?
          raise ArgumentError, 'Key and Secret are required'
        end
      end

      # let's define all rest calls even though betaface currently supports only POST
      # Maybe they'll adopt some RESTful best practice soon :)
      [:get, :put, :post, :delete].each do |method|
        method_class = Net::HTTP.const_get method.to_s.capitalize
        define_method method do |path, *args|
          payload = args[0]
          payload ||= {} 
          @config.host.chomp!("/") 
          path = ((path[0] == "/") ? path : ("/" + path).to_s)
          uri = URI(@config.host + path)
          request = method_class.new(uri, HTTP_HEADERS)
          payload[:api_secret] = @secret
          payload[:api_key] = @key
          request.body = payload.to_json if [:post, :put].include?(method)
          connect_and_send(request)
        end
      end

      protected

      ##
      # Send an HTTP request using the cached <tt>@connection</tt> object and
      # return the JSON response body parsed into a hash. Also save the raw
      # Net::HTTP::Request and Net::HTTP::Response objects as
      # <tt>@last_request</tt> and <tt>@last_response</tt> to allow for
      # inspection later.
      def connect_and_send(request) 
        @last_request = request
        retries_left = @config.retry_limit
        begin
          http = Net::HTTP.new(request.uri.host, request.uri.port)
          http.use_ssl = true if request.uri.scheme == "https"
          response = http.start do |h| 
            h.request(request)
          end
          @last_response = response
          if response.kind_of? Net::HTTPServerError
            raise Betaface::REST::ServerError
          end
        rescue
          raise if request.class == Net::HTTP::Post
          if retries_left > 0 then retries_left -= 1; retry else raise end
        end
        if response.body and !response.body.empty?
          object = MultiJson.load response.body
        elsif response.kind_of? Net::HTTPBadRequest
          object = { message: 'Bad request', code: 400 }
        end

        if response.kind_of? Net::HTTPClientError
          raise Betaface::REST::RequestError.new object['message'], object['code']
        end
        object
      end
    end
  end
end

