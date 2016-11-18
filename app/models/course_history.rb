class CourseHistory < ApplicationRecord
  belongs_to :student
  belongs_to :course_description
  has_many :semesters
end
