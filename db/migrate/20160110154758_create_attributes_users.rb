class CreateAttributesUsers < ActiveRecord::Migration
  def change
    create_table :attributes_users do |t|

      t.integer :user_id
      t.integer :attribute_id
      t.integer :order
      t.boolean :visible
    end
  end
end
