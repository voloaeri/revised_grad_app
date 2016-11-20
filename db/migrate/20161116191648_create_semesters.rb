class CreateSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :semesters do |t|
      t.references :course_description, foreign_key: true
      t.references :faculty
      t.integer :year
      t.string :semester
      t.string :secondary_title
      t.integer :section_override
      t.integer :category_override
      t.timestamps
    end
  end
end
