class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:new, :create]
  before_action :require_authorized_for_current_lesson, only: [:update]
  before_action :require_enrollment_for_current_lesson, only: [:show]

  def new
    @section = Section.find(params[:section_id])
    @lesson = Lesson.new
  end

  def create
    @section = Section.find(params[:section_id])
    @lesson = @section.lessons.create(lesson_params)
    redirect_to instructor_course_path(@section.course) 
  end

  def show
    @lesson = current_lesson
  end

  private

  def require_enrollment_for_current_lesson
    unless current_user.enrolled_in?(current_lesson.section.course)
      redirect_to root_url, alert: 'Must be enrolled to access'
    end
  end
  
  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end


  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end