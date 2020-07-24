class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :update, :destroy ]
  def index
    tasks = TaskBlueprint.render Task.sorted
    render json: tasks
  end

  def show
    render json: TaskBlueprint.render(@task, view: :extended)
  end

  def create
    if @task = Task.create(task_params)
      render json: TaskBlueprint.render(@task), status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @task.update(task_params)
      render json: TaskBlueprint.render(@task)
    else
      render json: { errors: @task.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @task.destroy
    render status: :no_content
  end

private
  def task_params
    params.require(:task).permit(:id, :uid, :title, :description, :task_id, :project_id, :status_id, :priority, :order)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
