module SessionsHelper
  # Manages session permissions based on type of user: admin, faculty, student.
  # Admin- can see everything and do everything
  # Faculty- can see everything, can make no changes
  # Student- can only see themselves, can change some stuff about themselves
  # Each function checks based on type of user and if a user is trying to access something they shouldn't the user is kicked out to login page and given an error message
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
