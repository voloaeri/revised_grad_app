class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :location
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
