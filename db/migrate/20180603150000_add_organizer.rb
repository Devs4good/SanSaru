class AddOrganizer < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :organizer, :boolean, null: false, default: false
  end
end
