module ReqresApiWrapper
  class Client
    def self.call(endpoint:, params: {})
      request = Request.new(endpoint: endpoint, params: params)
      raw_response = request.call
      Response.new(raw_response)
    rescue => e
      { error: "An error occurred: #{e.message}" }
    end
  end
end