class Semester < ApplicationRecord
  belongs_to :course_description
  has_many :course_histories
  belongs_to :faculty
end
