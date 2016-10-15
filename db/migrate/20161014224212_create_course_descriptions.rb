class CreateCourseDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :course_descriptions do |t|
      t.integer :number
      t.string :name
      t.string :section
      t.string :teacher
      t.string :semester
      t.string :category
      t.string :hours

      t.timestamps
    end
  end
end
