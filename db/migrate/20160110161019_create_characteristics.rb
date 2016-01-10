class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.text :attribute_column_name
      t.text :attribute_view_name
    end
  end
end
