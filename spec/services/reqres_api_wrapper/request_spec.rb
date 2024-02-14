require 'rails_helper'

RSpec.describe ReqresApiWrapper::Request, type: :service do
  describe '#call' do
    let(:endpoint) { 'users' }
    let(:params) { { page: 1 } }

    context 'when the request is successful', vcr: { cassette_name: "successful_request" } do
      it 'returns a hash' do
        request = described_class.new(endpoint: endpoint, params: params)
        expect(JSON.parse(request.call.body)).to be_a(Hash)
      end
    end

    context 'when the request fails with a non-success status', vcr: { cassette_name: "failed_request" } do
      it 'raises an error with the response status' do
        request = described_class.new(endpoint: 'unknown/23')
        expect { request.call }.to raise_error(/Error: \d{3}/)
      end
    end

    context 'when there is a connection failure' do
      before do
        allow_any_instance_of(Faraday::Connection).to receive(:get).and_raise(Faraday::ConnectionFailed.new(''))
      end

      it 'raises a connection failed error' do
        request = described_class.new(endpoint: endpoint)
        expect { request.call }.to raise_error("Connection failed")
      end
    end

    context 'when a client error occurs' do
      before do
        stub_request(:get, "https://reqres.in/api/#{endpoint}")
          .with(query: params)
          .to_raise(Faraday::ClientError.new('error', { status: 400 }))
      end

      let(:request) { described_class.new(endpoint: endpoint, params: params) }

      it 'raises a client error with the status code' do
        expect { request.call }.to raise_error("Client error: 400")
      end
    end

    context 'when the request times out' do
      before do
        stub_request(:get, "https://reqres.in/api/timeout_endpoint")
          .to_raise(Faraday::TimeoutError)
      end

      subject(:request) { described_class.new(endpoint: 'timeout_endpoint') }

      it 'raises a timeout error' do
        expect { request.call }.to raise_error("Request timed out")
      end
    end
  end
end