module ReqresApiWrapper
  class Response
    attr_reader :data, :meta

    def initialize(json_response)
      @response_hash = JSON.parse(json_response.body)
      parse_response
    end

    private

    def parse_response
      @data = @response_hash['data']

      @meta = {
        page: @response_hash['page'],
        per_page: @response_hash['per_page'],
        total: @response_hash['total'],
        total_pages: @response_hash['total_pages']
      }.compact
    end
  end
end