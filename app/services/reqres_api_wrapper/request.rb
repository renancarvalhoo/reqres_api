module ReqresApiWrapper
  class Request
    BASE_URL = 'https://reqres.in/api/'

    def initialize(endpoint:, params: {})
      @endpoint = endpoint
      @params = params
    end

    def call
      response = faraday_connection.get(@endpoint, @params)
      raise "Error: #{response.status}" unless response.success?

      response
    rescue Faraday::TimeoutError
      raise "Request timed out"
    rescue Faraday::ConnectionFailed
      raise "Connection failed"
    rescue Faraday::ClientError => e
      raise "Client error: #{e.response[:status]}"
    end

    private

    def faraday_connection
      Faraday.new(url: BASE_URL) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.request :json
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end