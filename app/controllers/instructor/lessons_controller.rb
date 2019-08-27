class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
    @lesson = current_lesson
  end

  private

 def require_authorized_for_current_lesson
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to courses_path, alert: 'You need to be enrolled to access lessons'
    end
  end

  helper_method :current_lesson
  def current_section
    @current_section ||= Lesson.find(params[:id])
  end
end

  
