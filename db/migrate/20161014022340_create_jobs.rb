class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :semester
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
