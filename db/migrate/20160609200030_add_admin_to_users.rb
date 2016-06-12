class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :venue_users, :role, :string, default: 'user'
  end
end
