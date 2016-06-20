class CreateSpaceEntries < ActiveRecord::Migration
  def change
    create_table :space_entries do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, index: true, foreign_key: true
      t.references :space, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
