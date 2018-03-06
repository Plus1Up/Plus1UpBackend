class Api::CoachesController < ApplicationController
  def index
    coaches = Coach.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded coaches', data: coaches}, status: :ok
  end

  def show
    coach = Coach.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded coaches', data: coach}, status: :ok
  end

  def create
    coach = Coach.new(coach_params)

    if coach.save
      render json: {status: 'SUCCESS', message: 'Saved coach', data: coach}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Coach not saved', data: coach.errors}, status: :unprocessable_entity

    end
  end

  def destroy
    coach = Coach.find(params[:id])
    coach.destroy
    render json: {status: 'SUCCESS', message: 'Deleted coach', data: coach}, status: :ok
  end

  def update
    coach = Coach.find(params[:id])

    if coach.update_attributes(coach_params)
      render json: {status: 'SUCCESS', message: 'Updated coach', data: coach}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Coach not updated', data: coach.errors}, status: :unprocessable_entity
    end

  end

  private

  def coach_params
    params.permit(:mailAddress, :password, :name, :lastname)
  end
end
