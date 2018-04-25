class Api::TrainingsController < ApplicationController

  before_action :set_client
  before_action :set_client_training, only: [:show, :update, :destroy]

  def_param_group :client_id do
    param :client_id, Integer, 'Unique client id', :required => true
  end

  def_param_group :id do
    param :id, Integer, 'Unique training id', :required => true
  end

  def_param_group :training_params do
    param :name, String, 'Name of training', :required => true
    param :weekday, Integer, 'Weekday of training. 0 is Monday', :required => true
  end

  api :GET, '/clients/:client_id/trainings', 'Show all trainings'
  description 'Return list of all trainings of client'
  param_group :client_id

  def index
    if @client
      render json: {status: 'SUCCESS', message: 'Loaded trainings', data: @client.trainings}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find client', data: nil}, status: :not_found
    end
  end

  api :GET, '/clients/:client_id/trainings/:id', 'Get a single traing details'
  param_group :id
  param_group :client_id

  def show
    if @training
      render json: {status: 'SUCCESS', message: 'Loaded training', data: @training}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find training', data: nil}, status: :not_found
    end
  end

  api :POST, '/clients/:client_id/trainings', 'Create new training'
  param_group :client_id
  param_group :training_params

  def create
    @training = Training.new(training_params)
    if @training.save
      render json: {status: 'SUCCESS', message: 'Training added', data: @training}, status: :created
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t add training', data: @training.errors}, status: :unprocessable_entity
    end
  end

  api :PUT, '/clients/:client_id/trainings/:id', 'Update training parameters'
  param_group :client_id
  param_group :id
  param_group :training_params, :as => :update

  def update
    if @training and @training.update(training_params)
      render json: {status: 'SUCCESS', message: 'Updated client', data: @training}, status: :no_content
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t update training', data: @training&.errors}, status: :unprocessable_entity
    end
  end

  api :DELETE, '/clients/:client_id/trainings/:id', 'Remove training'
  param_group :client_id
  param_group :id

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
