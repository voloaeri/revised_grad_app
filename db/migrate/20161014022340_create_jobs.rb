class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :position
      t.string :supervisor
      t.string :course
      t.references :student, foreign_key: true
      t.string :current
      t.timestamps
    end
  end
end
