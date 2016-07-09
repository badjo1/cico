class AddJoinedInOnVenueUsers < ActiveRecord::Migration
  def change
     add_column :venue_users, :joined_in, :datetime
  end
end
