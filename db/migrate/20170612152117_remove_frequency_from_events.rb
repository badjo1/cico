class RemoveFrequencyFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :repeat, :string
  end
end
