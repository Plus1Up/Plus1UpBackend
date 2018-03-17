class Api::DietPlansController < ApplicationController
  def index
    diet_plans = DietPlan.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded diet plans', data: diet_plans}, status: :ok
  end

  def show
    diet_plan = DietPlan.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded diet plan', data: diet_plan}, status: :ok
  end

  def create
    diet_plan = DietPlan.new(client_params)
    if diet_plan.save
      render json: {status: 'SUCCESS', message: 'Saved diet plan', data: diet_plan}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Diet plan not saved', data: diet_plan.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    diet_plan = DietPlan.find(params[:id])
    diet_plan.destroy
    render json: {status: 'SUCCESS', message: 'Deleted diet plan', data: diet_plan}, status: :ok
  end

  def update
    diet_plan = DietPlan.find(params[:id])
    if diet_plan.update_attributes(coach_params)
      render json: {status: 'SUCCESS', message: 'Updated diet plan', data: diet_plan}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Diet plan not updated', data: diet_plan.errors}, status: :unprocessable_entity
    end
  end

  private

  def diet_plan_params
    params.permit()
  end
end
