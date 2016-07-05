class RenameActivatedAtIntoVisitOn < ActiveRecord::Migration
  def change
    rename_column :venue_users, :activated_at, :visit_on
  end
end
