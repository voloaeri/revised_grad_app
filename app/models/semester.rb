class Semester < ApplicationRecord
  belongs_to :course_description
  belongs_to :course_history
end
