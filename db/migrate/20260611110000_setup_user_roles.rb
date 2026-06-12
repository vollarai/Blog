class SetupUserRoles < ActiveRecord::Migration[8.1]
  ADMIN = 1
  USER = 2

  def up
    add_column :users, :roles, :integer, default: USER, null: false
    User.where(admin: true).update_all(roles: ADMIN | USER)
    remove_column :users, :admin
  end

  def down
    add_column :users, :admin, :boolean, default: false, null: false
    User.where("roles & ? > 0", ADMIN).update_all(admin: true)
    remove_column :users, :roles
  end
end
