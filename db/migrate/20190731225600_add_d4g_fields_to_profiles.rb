class AddD4gFieldsToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :linkedin, :string
    add_column :profiles, :heard_or_see_d4g, :text
    add_column :profiles, :tech_stack, :text
    add_column :profiles, :owned_projects, :text
  end
end
