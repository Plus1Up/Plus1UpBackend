class Api::ClientsController < ApplicationController

  SAMPLE_GET_CLIENTS_RESPONSE = '{
  "status": "SUCCESS",
  "message": "Loaded clients",
  "data": [
    {
      "id": 20,
      "coach_id": 4,
      "mail_address": "maymie_mosciski@stehrjohnson.io",
      "password": "MgQ8X8",
      "name": "Alivia",
      "last_name": "Lowe",
      "is_pending": false,
      "is_active": false,
      "created_at": "2018-03-17T19:16:24.727Z",
      "updated_at": "2018-03-17T19:16:24.727Z"
    },
    {
      "id": 19,
      "coach_id": 1,
      "mail_address": "vita_bernier@bergnaum.co",
      "password": "0aC37",
      "name": "Ashleigh",
      "last_name": "Cummings",
      "is_pending": true,
      "is_active": true,
      "created_at": "2018-03-17T19:16:24.722Z",
      "updated_at": "2018-03-17T19:16:24.722Z"
    }
  ]
}'

  SAMPLE_GET_CLIENT_RESPONSE = '{
  "status": "SUCCESS",
  "message": "Client loaded",
  "data": {
    "id": 19,
    "coach_id": 1,
    "mail_address": "vita_bernier@bergnaum.co",
    "password": "0aC37",
    "name": "Ashleigh",
    "last_name": "Cummings",
    "is_pending": true,
    "is_active": true,
    "created_at": "2018-03-17T19:16:24.722Z",
    "updated_at": "2018-03-17T19:16:24.722Z"
  }
}'

  def_param_group :id do
    param :id, Integer, "Unique client id", :required => true
  end

  def_param_group :client_params do
    param :mail_address, String, "Unique email address", :required => true, :action_aware => true
    param :password, String, "Plaintext password", :required => true, :action_aware => true
    param :name, String, "First name of client", :required => true, :action_aware => true
    param :lat_name, String, "Last name of client", :required => true, :action_aware => true
  end

  api :GET, '/clients', 'Show all clients details'
  error :code => 404, :desc => 'Not Found'
  description 'Return list of all clients in system'

  example SAMPLE_GET_CLIENTS_RESPONSE

  def index
    clients = Client.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded clients', data: clients}, status: :ok
  end

  api :GET, '/clients/:id', 'Get a single client details'
  param_group :id
  example SAMPLE_GET_CLIENT_RESPONSE

  def show
    client = Client.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Client loaded', data: client}, status: :ok
  end

  api :POST, '/clients', 'Create new client'
  param_group :client_params

  def create
    client = Client.new(client_params)
    if client.save
      render json: {status: 'SUCCESS', message: 'Saved client', data: client}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Client not saved', data: client.errors}, status: :unprocessable_entity
    end
  end

  api :DELETE, '/clients/:id', 'Remove client'
  param_group :id

  def destroy
    client = Client.find(params[:id])
    client.destroy
    render json: {status: 'SUCCESS', message: 'Deleted client', data: client}, status: :ok
  end

  api :PUT, '/clients/:id', 'Update client'
  param_group :id
  param_group :client_params, :as => :update

  def update
    client = Client.find(params[:id])
    if client.update_attributes(coach_params)
      render json: {status: 'SUCCESS', message: 'Updated client', data: client}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Client not updated', data: client.errors}, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.permit(:mail_address, :password, :name, :last_name)
  end
end