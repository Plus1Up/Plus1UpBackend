class Api::CoachesController < ApplicationController

  def_param_group :id do
    param :id, Integer, 'Unique coach id', :required => true
  end

  def_param_group :coach_params do
    param :mail_address, String, 'Unique email address', :required => true, :action_aware => true
    param :password, String, 'Plaintext password', :required => true, :action_aware => true
    param :name, String, 'First name of coach', :required => true, :action_aware => true
    param :last_name, String, 'Last name of coach', :required => true, :action_aware => true
  end

  api :GET, '/coaches', 'Show all coaches'
  description 'Return list of all coaches in system'

  def index
    coaches = Coach.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded coaches', data: coaches}, status: :ok
  end

  # api :GET, '/coaches/:id', 'Get a single coach details'
  # param_group :id
  #
  # def show
  #   coach = Coach.find(params[:id])
  #   render json: {status: 'SUCCESS', message: 'Loaded coaches', data: coach}, status: :ok
  # end

  api :POST, '/coaches', 'Create new coach'
  param_group :coach_params

  def create
    coach = Coach.new(coach_params)
    if coach.save
      render json: {status: 'SUCCESS', message: 'Saved coach', data: coach}, status: :created
    else
      render json: {status: 'ERROR', message: 'Coach not saved', data: coach.errors}, status: :unprocessable_entity
    end
  end

  api :PUT, '/coaches', 'Update coach data'
  param_group :id
  param_group :coach_params, :as => :update

  def update
    coach = Coach.find_by_id(params[:id])
    if coach != nil && coach.update_attributes(coach_params)
      render json: {status: 'SUCCESS', message: 'Updated coach', data: coach}, status: :no_content
    else
      render json: {status: 'ERROR', message: 'Coach not updated', data: coach&.errors}, status: :not_found
    end
  end


  api :DELETE, '/coaches/:id', 'Remove coach with all his clients'
  param_group :id

  def destroy
    coach = Coach.find(params[:id])
    coach.destroy
    render json: {status: 'SUCCESS', message: 'Deleted coach', data: coach}, status: :ok
  end


  private

  def coach_params
    params.permit(:mail_address, :password, :name, :last_name)
  end
end
