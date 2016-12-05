module SessionsHelper

  def log_in_student(user)
    session[:student_id] = user.id
  end

  def log_in_faculty
    session[:faculty] = true
  end

  def log_in_admin
    session[:admin] = true
  end

end
