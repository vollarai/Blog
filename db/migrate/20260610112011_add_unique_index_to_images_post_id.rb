class AddUniqueIndexToImagesPostId < ActiveRecord::Migration[8.1]
  def change
    remove_index :images, :post_id
    add_index :images, :post_id, unique: true
  end
end
