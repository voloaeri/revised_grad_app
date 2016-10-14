class Student < ApplicationRecord
  has_many :jobs
  has_many :documents
end
