class AddActivatedOnToVenueUsers < ActiveRecord::Migration
  def change
    add_column :venue_users, :activated_at, :datetime

    add_index :venue_users, [:user_id, :activated_at]
    add_index :venue_users, [:user_id, :venue_id], unique: true

  end
end
