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

  def update_order
    begin
      status_ids = status_order_params[:ids_in_order]
      statuses = Status.where(id: status_ids).order(:order)

      ids_difference = status_ids - statuses.pluck(:id)
      if ids_difference.length > 0
        raise "Unknown column detected"
      end

      # TODO: check for id not sent in ids_in_order

      statuses.each do |status|
        status.update(order: status_ids.find_index(status.id))
      end
      render json: statuses.reload.map {|status| StatusBlueprint.render(status) }
    rescue Exception => e
      render json: e, status: :bad_request
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

  def status_order_params
    params.permit(:project_id, ids_in_order: [])
  end

  def set_status
    @status = Status.find(params[:id])
  end
end
