class AddUserToCommentsRemoveCommenter < ActiveRecord::Migration[8.1]
  def change
    execute("DELETE FROM comments")
    add_reference :comments, :user, null: false, foreign_key: true
    remove_column :comments, :commenter, :string
  end
end
