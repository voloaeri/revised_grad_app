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

  def allow_admin
    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end

  def allow_admin_faculty_no_edit user
    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    elsif session[:faculty]
      redirect_to student_url user
      return false
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end

  def allow_faculty
    if(session[:admin] || session[:faculty])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end

  def allow_student(id)
    id=id.to_i
    if(session[:admin]) || session[:faculty] || session[:student_id] == id
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end

  def allow_student_only(id)
    id=id.to_i
    if session[:student_id] == id
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end

  def allow_admin_and_student id
    id=id.to_i
    if(session[:admin]) || session[:student_id] == id
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
      return true
    else
      flash[:alert] = "You either don't have permission or aren't logged in yet!"
      redirect_to login_url
      return false
    end
  end


end
