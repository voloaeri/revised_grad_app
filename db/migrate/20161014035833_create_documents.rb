class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :location
      t.boolean :background_sheet, default: false
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
