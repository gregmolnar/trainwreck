class AddUploaderToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_reference :documents, :uploader, foreign_key: { to_table: :users }
  end
end
