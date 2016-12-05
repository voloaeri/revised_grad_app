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
    else
      raise "no access".inspect
    end
  end

  def allow_faculty
    if(session[:admin])
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end
  end

  def allow_student(id)
    if(session[:admin]) || session[:faculty] || session[:student_id] == id
      puts session[:admin]
      puts session[:faculty]
      puts session[:student_id]
    else
      raise "no access".inspect
    end
  end

end
