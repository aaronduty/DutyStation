class ProjectsController < ApplicationController
  before_action :set_project, only: [ :show, :update, :destroy ]
  def index
    projects = ProjectBlueprint.render Project.sorted
    render json: projects
  end

  def show
    render json: ProjectBlueprint.render(@project, view: :extended)
  end

  def create
    if @project = Project.create(project_params)
      render json: ProjectBlueprint.render(@project), status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @project.update(project_params)
      render json: ProjectBlueprint.render(@project)
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @project.destroy
    render status: :no_content
  end

private
  def project_params
    params.require(:project).permit(:id, :name, :abbreviation, :order)
  end

  def set_project
    @project = Project.includes(:statuses).find(params[:id])
  end
end
