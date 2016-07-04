class AddEventTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_type, :string, null: false, default: 'appointment'
  end
end
