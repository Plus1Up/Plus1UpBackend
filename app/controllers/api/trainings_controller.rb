class Api::TrainingsController < ApplicationController

  before_action :set_client
  before_action :set_client_training, only: [:show, :update, :destroy]

  # GET /trainings
  def index
    if @client
      render json: {status: 'SUCCESS', message: 'Loaded trainings', data: @client.trainings}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find client', data: nil}, status: :not_found
    end
  end

  # GET /trainings/:id
  def show
    if @training
      render json: {status: 'SUCCESS', message: 'Loaded training', data: @training}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find training', data: nil}, status: :not_found
    end
  end

  # POST /trainings
  def create
    @training = Training.new(training_params)
    if @training.save
      render json: {status: 'SUCCESS', message: 'Training added', data: @training}, status: :created
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t add training', data: @training.errors}, status: :unprocessable_entity
    end
  end

  # PUT /trainings/1
  def update
    if @training and @training.update(training_params)
      render json: {status: 'SUCCESS', message: 'Updated client', data: @training}, status: :no_content
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t update training', data: @training&.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /trainings/1
  def destroy
    @training.destroy
  end

  private

  def set_client
    @client = Client.find_by_id(params[:client_id])
  end

  def set_client_training
    @training = @client.trainings.find_by_id(params[:id])
  end

  def training_params
    params.permit(:client_id, :name, :weekday)
  end

end
