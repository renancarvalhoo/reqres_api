class EmployeesController < ApplicationController
  def index
    reqres_response = ReqresApiWrapper::Client.call(endpoint: 'users', params: { page: params[:page] || 1 })

    if reqres_response.is_a?(Hash) && reqres_response.key?(:error)
      flash[:error] = reqres_response[:error]
    else
      @employees = reqres_response.data
      @pagination_info = reqres_response.meta
    end
  end

  def show
    reqres_response = ReqresApiWrapper::Client.call(endpoint: "users/#{params[:id]}")

    if reqres_response.is_a?(Hash) && reqres_response.key?(:error)
      flash[:error] = reqres_response[:error]
    else
      @employee = reqres_response.data
    end
  end
end
