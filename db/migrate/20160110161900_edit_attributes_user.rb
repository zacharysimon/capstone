class EditAttributesUser < ActiveRecord::Migration
  def change
    rename_column :attributes_users, :attribute_id, :characteristic_id
  end
end
