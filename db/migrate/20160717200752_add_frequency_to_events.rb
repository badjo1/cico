class AddFrequencyToEvents < ActiveRecord::Migration
  def change
      add_column :events, :repeat, :string, default: 'none'
  end
end
