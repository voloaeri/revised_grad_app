class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :firstName
      t.string :lastName
      t.string :PID

      t.timestamps
    end
  end
end
