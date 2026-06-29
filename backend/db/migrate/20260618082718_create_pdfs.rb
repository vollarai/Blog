class CreatePdfs < ActiveRecord::Migration[8.1]
  def change
    create_table :pdfs do |t|
      t.references :post, null: false, foreign_key: true
      t.string :status
      t.string :filename

      t.timestamps
    end
  end
end
