class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :subdomain

      t.timestamps null: false
    end

    add_index :venues, :subdomain, unique: true
  end
end
