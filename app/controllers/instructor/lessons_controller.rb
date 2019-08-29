class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update]
  before_action :require_authorized_for_current_lesson, only: [:show]
  before_action :require_authorized_for_current_lesson, only: [:create]
  skip_before_action :verify_authenticity_token

       def new
           @lesson = Lesson.new
        end
    
   def show    
    @lesson = current_lesson    
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end
  

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'updated!'
  end

  private

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      render plain: 'You need to be enrolled to access lessons', status: :unauthorized
    end
  end

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      return render plain: 'You need to be enrolled to access the section', status: :unauthorized
    end
  end

  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end

end

  
