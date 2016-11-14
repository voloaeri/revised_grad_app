class CourseDescription < ApplicationRecord
  attr_accessor :teacher, :semester, :year
  def student=(var)
    @student = var
  end

  def student
    @student
  end
end
