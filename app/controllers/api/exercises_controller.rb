class Api::ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :update, :destroy]

  # GET /exercises
  def index
    @exercises = Exercise.all

    render json: {status: 'SUCCESS', message: 'Loaded exercises', data: @exercises}, status: :ok
  end

  # GET /exercises/1
  def show
    if @exercise != nil
      render json: {status: 'SUCCESS', message: 'Exercise loaded', data: @exercise}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find exercise', data: @exercise}, status: :not_found
    end
  end

  # POST /exercises
  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      render json: {status: 'SUCCESS', message: 'Exercise saved', data: @exercise}, status: :created
    else
      render json: {status: 'ERROR', message: 'Exercise not saved', data: @exercise.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercises/1
  def update
    if @exercise and @exercise.update(exercise_params)
      render json: {status: 'SUCCESS', message: 'Updated exercise', data: @exercise}, status: :no_content
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t update training', data: @exercise&.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /exercises/1
  def destroy
    @exercise.destroy
    render json: {status: 'SUCCESS', message: 'Exercise removed', data: @exercise}, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercise
    @exercise = Exercise.find_by_id(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def exercise_params
    params.permit(:name, :category)
  end
end
