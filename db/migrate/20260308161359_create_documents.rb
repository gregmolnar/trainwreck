class CreateDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :external_url
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
