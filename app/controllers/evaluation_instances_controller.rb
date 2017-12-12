class EvaluationInstancesController < ApplicationController
  before_action :set_evaluation_instances
  before_action :set_evaluation_instance, only: [:show, :edit, :update, :destroy]

  # GET courses/1/evaluation_instances
  def index
    @evaluation_instances = @courses.evaluation_instances
  end

  # GET courses/1/evaluation_instances/1
  def show
  end

  # GET courses/1/evaluation_instances/new
  def new
    @evaluation_instance = @courses.evaluation_instances.build
  end

  # GET courses/1/evaluation_instances/1/edit
  def edit
  end

  # POST courses/1/evaluation_instances
  def create
    @evaluation_instance = @courses.evaluation_instances.build(evaluation_instance_params)

    if @evaluation_instance.save
      redirect_to([@evaluation_instance.courses, @evaluation_instance], notice: 'Evaluation instance was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT courses/1/evaluation_instances/1
  def update
    if @evaluation_instance.update_attributes(evaluation_instance_params)
      redirect_to([@evaluation_instance.courses, @evaluation_instance], notice: 'Evaluation instance was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE courses/1/evaluation_instances/1
  def destroy
    @evaluation_instance.destroy

    redirect_to courses_evaluation_instances_url(@courses)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation_instances
      @courses = Course.find(params[:courses_id])
    end

    def set_evaluation_instance
      @evaluation_instance = @courses.evaluation_instances.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def evaluation_instance_params
      params.require(:evaluation_instance).permit(:title, :date, :passing_core)
    end
end