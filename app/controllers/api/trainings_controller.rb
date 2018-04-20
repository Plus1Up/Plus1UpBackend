class Api::TrainingsController < ApplicationController

  before_action :set_client
  before_action :set_client_training, only: [:show, :update, :destroy]

  # GET /trainings
  def index
    if @client != nil
      render json: {status: 'SUCCESS', message: 'Loaded trainings', data: @client.trainings}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find client', data: nil}, status: :not_found
    end
  end

  # GET /trainings/1
  def show
    render json: @training
  end

  # POST /trainings
  def create
    @training = Training.new(training_params)

    if @training.save
      render json: @training, status: :created, location: @training
    else
      render json: @training.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trainings/1
  def update
    if @training.update(training_params)
      render json: @training
    else
      render json: @training.errors, status: :unprocessable_entity
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
    @training = @client.trainings.find_by!(id: params[:id])
  end

end
