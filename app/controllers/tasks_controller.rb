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

  def update_order
    task = Task.find(params[:task_id])
    old_status_id = task.status_id
    task = task.update(task_params)
    begin
      task_ids = task_order_params[:ids_in_order]
      tasks = Task.where(id: task_ids).order(:order)

      # check for extra id send down
      ids_difference = task_ids - tasks.pluck(:id)
      if ids_difference.length > 0
        raise "Unknown column detected"
      end

      # TODO: check for id not sent in ids_in_order

      tasks.each do |status|
        status.update(order: task_ids.find_index(status.id))
      end
      render json: tasks.reload.map {|task| TaskBlueprint.render(task) }
    rescue Exception => e
      task.update(status_id: old_status_id) # revert any potential status change
      render json: e, status: :bad_request
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

  def task_order_params
    params.permit(ids_in_order: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
