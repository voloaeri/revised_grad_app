class CourseHistory < ApplicationRecord
  belongs_to :student
  belongs_to :course_description
  belongs_to :semester

  attr_accessor :teacher, :semester, :year, :number, :name
end
