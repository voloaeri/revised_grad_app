class CreateCourseHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :course_histories do |t|
      t.references :student, foreign_key: true
      t.references :course_description, foreign_key: true
      t.references :semester, foreign_key: true
      t.string :grade
      t.timestamps
    end
  end
end
