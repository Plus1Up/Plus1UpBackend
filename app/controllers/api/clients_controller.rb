class Api::ClientsController < ApplicationController
  def index
    coaches = Client.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded clients', data: coaches}, status: :ok
  end

  def show
    coach = Client.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded clients', data: coach}, status: :ok
  end

  def create
    coach = Client.new(client_params)
    if coach.save
      render json: {status: 'SUCCESS', message: 'Saved client', data: coach}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Coach not saved', data: coach.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    coach = Client.find(params[:id])
    coach.destroy
    render json: {status: 'SUCCESS', message: 'Deleted client', data: coach}, status: :ok
  end

  def update
    coach = Client.find(params[:id])
    if coach.update_attributes(coach_params)
      render json: {status: 'SUCCESS', message: 'Updated client', data: coach}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Client not updated', data: coach.errors}, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.permit(:mailAddress, :password, :name, :lastname)
  end
end
