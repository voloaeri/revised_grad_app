class CourseDescription < ApplicationRecord
  has_many :semesters
  attr_accessor :teacher, :semester, :year, :second_title, :section_override, :category_override
  def student=(var)
    @student = var
  end

  def student
    @student
  end
end
