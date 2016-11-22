class CourseHistory < ApplicationRecord
  belongs_to :student
  belongs_to :course_description
  belongs_to :semester

  attr_accessor :teacher, :year, :number, :name
end
