class DeleteSubdomainFromVenue < ActiveRecord::Migration
  def change
    remove_column :venues, :subdomain, :string
  end
end
