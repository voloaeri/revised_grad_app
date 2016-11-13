class CourseDescription < ApplicationRecord
  def student=(var)
    @student = var
  end

  def student
    @student
  end
end
