class CreateCourseHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :course_histories do |t|
      t.references :student, foreign_key: true
      t.references :course_description, foreign_key: true
      t.string :grade
      t.string :section
      t.references :faculty
      t.string :semester

      t.timestamps
    end
  end
end
