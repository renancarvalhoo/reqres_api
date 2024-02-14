require 'rails_helper'

RSpec.describe ReqresApiWrapper::Response do
  describe 'integration with ReqresRequest' do
    let(:endpoint) { 'users' }
    let(:params) { { page: 1 } }

    context 'when the request is successful', vcr: { cassette_name: 'successful_request' } do
      it 'correctly parses the data and meta from the response' do
        raw_response = ReqresApiWrapper::Request.new(endpoint: endpoint, params: params).call

        response = ReqresApiWrapper::Response.new(raw_response)

        expect(response.data).to all(be_a(Hash))
        expect(response.data.first.keys).to include('id', 'email', 'first_name', 'last_name', 'avatar')

        expect(response.meta.keys).to include(:page, :per_page, :total, :total_pages)
        expect(response.meta[:page]).to eq(1)
      end
    end
  end
end