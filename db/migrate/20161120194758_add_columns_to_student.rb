class AddColumnsToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :PRP, :string
    add_column :students, :oralExam, :string
    add_column :students, :committeeMeeting, :string
    add_column :students, :ABD, :string
    add_column :students, :dissertation_defense, :string
    add_column :students, :finalDiss, :string
  end
end
