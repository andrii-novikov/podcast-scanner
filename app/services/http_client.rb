class HttpClient
  class << self
    HTTP_METHODS = %i[get post put patch delete]
    delegate *HTTP_METHODS, to: :client

    def client
      @client ||= Faraday.new do |b|
        b.use FaradayMiddleware::FollowRedirects
        b.adapter Faraday.default_adapter
      end
    end
  end
end