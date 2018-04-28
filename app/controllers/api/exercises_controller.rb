class Api::ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :update, :destroy]

  def_param_group :id do
    param :id, Integer, 'Unique exercise id', :required => true
  end

  def_param_group :exercise_params do
    param :name, String, 'Name of exercise', :required => true, :action_aware => true
    param :category, Exercise.categories.collect {|category| category[0]}, :required => true, :action_aware => true
  end

  def_param_group :coach_id do
    param :coach_id, Integer, 'Unique coach id', :required => true
  end

  api :GET, '/exercises', 'Show all exercises'
  description 'Return list of all exercises in system'

  def index
    @exercises = Exercise.all

    render json: {status: 'SUCCESS', message: 'Loaded exercises', data: @exercises}, status: :ok
  end

  api :GET, '/exercises/:id', 'Get a single exercise details'
  param_group :id

  def show
    if @exercise != nil
      render json: {status: 'SUCCESS', message: 'Exercise loaded', data: @exercise}, status: :ok
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t find exercise', data: @exercise}, status: :not_found
    end
  end

  api :POST, '/exercises', 'Create new exercise'
  param_group :coach_id
  param_group :exercise_params, :as => :create

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      render json: {status: 'SUCCESS', message: 'Exercise saved', data: @exercise}, status: :created
    else
      render json: {status: 'ERROR', message: 'Exercise not saved', data: @exercise.errors}, status: :unprocessable_entity
    end
  end

  api :PUT, '/exercises/:id', 'Update exercise parameters'
  param_group :id
  param_group :exercise_params, :as => :update

  def update
    if @exercise and @exercise.update(exercise_params)
      render json: {status: 'SUCCESS', message: 'Updated exercise', data: @exercise}, status: :no_content
    else
      render json: {status: 'FAILURE', message: 'Couldn\'t update training', data: @exercise&.errors}, status: :unprocessable_entity
    end
  end

  api :DELETE, '/exercises/:id', 'Remove exercise'
  param_group :id
  
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
    params.permit(:coach_id, :name, :category)
  end
end
