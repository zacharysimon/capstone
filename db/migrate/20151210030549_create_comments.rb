class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :listing_id
      t.integer :score
      t.text :comment
      t.string :type

      t.timestamps null: false
    end
  end
end
