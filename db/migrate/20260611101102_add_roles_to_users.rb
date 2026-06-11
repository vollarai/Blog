class AddRolesToUsers < ActiveRecord::Migration[8.1]
  ADMIN = 1
  USER = 2

  def change
    add_column :users, :roles, :integer, default: 0, null: false
    User.where(admin: true).update_all(roles: ADMIN | USER)
    User.where(admin: false).update_all(roles: USER)
    remove_column :users, :admin
  end
end
