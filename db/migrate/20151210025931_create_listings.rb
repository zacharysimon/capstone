class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.text :street_adress
      t.string :zip_code
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.string :walk_score
      t.string :transit_score
      t.integer :rent_zestimate
      t.string :url
      t.integer :tax_assessment
      t.integer :sqft
      t.string :yearbuilt
      t.string :lastdatesold
      t.integer :lastsoldprice
      t.integer :bathrooms
      t.integer :bedrooms
      t.text :images
      t.integer :zpid
      t.integer :price
      t.integer :mls_number
      t.integer :zws_id
      t.string :home_type
      t.text :walkscore_description
      t.integer :hoa_assessment
      t.boolean :rent_cap
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
