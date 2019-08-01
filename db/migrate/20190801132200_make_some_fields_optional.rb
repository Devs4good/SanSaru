class MakeSomeFieldsOptional < ActiveRecord::Migration[5.2]
  def up
    change_column :profiles, :agile_id, :bigint, null: true, default: ''
    change_column :profiles, :agileRelation_id, :bigint, null: true, default: ''
    change_column :profiles, :agile_description, :string, null: true, default: ''
  end

  def down
    change_column :profiles, :agile_id, :bigint, null: false
    change_column :profiles, :agileRelation_id, :bigint, null: false
    change_column :profiles, :agile_description, :string, null: false
  end
end
