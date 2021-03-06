class Student < ApplicationRecord
  has_many :jobs
  has_many :documents
  has_many :course_histories
  has_many :course_descriptions, through: :course_histories
  attr_accessor :startedSemester, :startedYear
  attr_accessor :approvedSemester, :approvedYear

end
