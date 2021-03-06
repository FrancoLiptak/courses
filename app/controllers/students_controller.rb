class StudentsController < ApplicationController
  before_action :set_students
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET courses/1/students
  def index
    @students = @courses.students
  end

  # GET courses/1/students/new
  def new
    @student = @courses.students.build
  end

  # GET courses/1/students/1/edit
  def edit
  end

  # POST courses/1/students
  def create
    @student = @courses.students.build(student_params)

    if @student.save
      redirect_to course_students_url, notice: 'Student was successfully created.'
    else
      render action: 'new'
    end
  end

  # PUT courses/1/students/1
  def update
    if @student.update_attributes(student_params)
      redirect_to course_students_url, notice: 'Student was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE courses/1/students/1
  def destroy
    if (!@student.scores.empty?)
      redirect_to course_students_url, alert: 'This student can not be deleted. It has associated results.'
    else
      @student.destroy
      redirect_to course_students_url(@courses), notice: 'Student was successfully deleted.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_students
      @courses = Course.find(params[:course_id])
    end

    def set_student
      @student = @courses.students.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:last_name, :name, :dni, :student_number, :email)
    end
end
