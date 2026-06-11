class DefaultUserRoles < ActiveRecord::Migration[8.1]
  USER = 2

  def change
    change_column_default :users, :roles, from: 0, to: USER
    User.where(roles: 0).update_all(roles: USER)
  end
end
