class AddDefaulttoCharacteristic < ActiveRecord::Migration
 def change
    add_column :characteristics, :default_visible, :boolean
    add_column :characteristics, :default_order, :integer 
  end
end
