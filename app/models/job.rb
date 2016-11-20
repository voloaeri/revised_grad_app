class Job < ApplicationRecord
  belongs_to :student
  attr_accessor :semester, :year
end
