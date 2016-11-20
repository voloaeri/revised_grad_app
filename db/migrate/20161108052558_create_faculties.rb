class CreateFaculties < ActiveRecord::Migration[5.0]
  def change
    create_table :faculties do |t|
      t.string :firstName
      t.string :lastName
      t.string :sectionNumber
      t.string :PID
      t.string :isAdmin
      #t.references :semester, foreign_key: true
      t.timestamps
    end
  end
end
