class AddDepartmentToCourseDescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :course_descriptions, :department, :string
  end
end
