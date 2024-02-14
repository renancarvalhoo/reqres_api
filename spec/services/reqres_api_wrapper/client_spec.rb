require 'rails_helper'

RSpec.describe ReqresApiWrapper::Client do
  describe '.call' do
    let(:endpoint) { 'users' }
    let(:params) { { page: 1 } }

    context 'when the request is successful', vcr: { cassette_name: 'successful_request' } do
      it 'returns an instance of ReqresResponse with the correct data' do
        response = ReqresApiWrapper::Client.call(endpoint: endpoint, params: params)

        expect(response).to be_a(ReqresApiWrapper::Response)
        expect(response.data).to all(be_a(Hash))
        expect(response.data.first.keys).to include('id', 'email', 'first_name', 'last_name', 'avatar')
      end
    end

    context 'when an error occurs' do
      before do
        allow(ReqresApiWrapper::Request).to receive(:new).and_raise(StandardError.new('An error occurred'))
      end

      it 'returns a hash with an error message' do
        expect(ReqresApiWrapper::Client.call(endpoint: 'invalid', params: {})).to eq({ error: 'An error occurred: An error occurred' })
      end
    end
  end
end