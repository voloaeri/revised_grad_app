class CourseHistory < ApplicationRecord
  belongs_to :student
  belongs_to :course_description
end
