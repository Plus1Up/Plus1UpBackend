class Api::ClientsController < ApplicationController
  def index
    clients = Client.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded clients', data: clients}, status: :ok
  end

  def show
    client = Client.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded clients', data: client}, status: :ok
  end

  def create
    client = Client.new(client_params)
    if client.save
      render json: {status: 'SUCCESS', message: 'Saved client', data: client}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Coach not saved', data: client.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    render json: {status: 'SUCCESS', message: 'Deleted client', data: client}, status: :ok
  end

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
