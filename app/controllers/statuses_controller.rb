class StatusesController < ApplicationController
  before_action :set_status, only: [ :show, :update, :destroy ]
  def index
    statuss = StatusBlueprint.render Status.sorted
    render json: statuss
  end

  def show
    render json: StatusBlueprint.render(@status, view: :extended)
  end

  def create
    if @status = Status.create(status_params)
      render json: StatusBlueprint.render(@status), status: :created
    else
      render json: { errors: @status.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @status.update(status_params)
      render json: StatusBlueprint.render(@status)
    else
      render json: { errors: @status.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @status.destroy
    render status: :no_content
  end

private
  def status_params
    params.require(:status).permit(:id, :name, :order, :project_id)
  end

  def set_status
    @status = Status.find(params[:id])
  end
end
