class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    student = Student.find_by(PID: params[:session][:PID].strip)
    faculty = Faculty.find_by(PID: params[:session][:PID].strip)
    admin = Admin.find_by(PID: params[:session][:PID].strip)

    if student
      log_in_student student
      redirect_to student
    elsif faculty
      log_in_faculty
      redirect_to students_url
    elsif admin
      log_in_admin
      redirect_to students_url
    else
      #render error
    end

  end

  def destroy
    puts :end
  end

end
