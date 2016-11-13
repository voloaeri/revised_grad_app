class AddCurrentToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :current, :string
  end
end
