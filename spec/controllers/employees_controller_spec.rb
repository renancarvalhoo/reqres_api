require 'rails_helper'

RSpec.describe EmployeesController do
  describe 'GET #index' do
    let(:params) { { page: 1 } }
    let(:successful_response) { instance_double(ReqresApiWrapper::Response, data: 'data', meta: 'meta') }

    context 'when API call is successful' do
      before do
        allow(ReqresApiWrapper::Client).to receive(:call).and_return(successful_response)
        get :index, params: params
      end

      it 'assigns @employees' do
        expect(assigns(:employees)).to eq('data')
      end

      it 'assigns @pagination_info' do
        expect(assigns(:pagination_info)).to eq('meta')
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when API call fails' do
      before do
        allow(ReqresApiWrapper::Client).to receive(:call).and_return({ error: 'API error occurred' })
        get :index, params: params
      end

      it 'sets a flash error message' do
        expect(flash[:error]).to eq('API error occurred')
      end
    end
  end

  describe 'GET #show' do
    let(:employee_id) { 1 }
    let(:successful_response) { instance_double(ReqresApiWrapper::Response, data: 'employee_data') }

    context 'when API call is successful' do
      before do
        allow(ReqresApiWrapper::Client).to receive(:call).and_return(successful_response)
        get :show, params: { id: employee_id }
      end

      it 'assigns @employee' do
        expect(assigns(:employee)).to eq('employee_data')
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when API call fails' do
      before do
        allow(ReqresApiWrapper::Client).to receive(:call).and_return({ error: 'API error occurred' })
        get :show, params: { id: employee_id }
      end

      it 'sets a flash error message' do
        expect(flash[:error]).to eq('API error occurred')
      end
    end
  end
end
