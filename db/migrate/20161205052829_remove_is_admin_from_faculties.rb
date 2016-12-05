class RemoveIsAdminFromFaculties < ActiveRecord::Migration[5.0]
  def change
    remove_column :faculties, :isAdmin, :string
  end
end
