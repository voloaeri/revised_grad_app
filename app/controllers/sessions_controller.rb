class SessionsController < ApplicationController
  def new
    render 'new'
  end
  # Creates the original session on login. Uses PID only right now. Go to helpers, sessions for the functions used to check what session and persmissions to give people
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
      flash[:alert] = "That PID isn't in our database!"
      redirect_to login_url
    end

  end

  def not_found
    
  end
  # Logs them out and destroys the session upon click of the logout button
  def destroy
    reset_session
    flash[:success] = "You have been logged out!"
    redirect_to login_url

  end

end
