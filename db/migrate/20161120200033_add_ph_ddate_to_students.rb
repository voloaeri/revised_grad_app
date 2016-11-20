class AddPhDdateToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :phdAdmitDate, :string
  end
end
