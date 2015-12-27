class ChangeAttributesOfListings < ActiveRecord::Migration
  def change
    remove_column :listings, :home_type, :string
    remove_column :listings, :walkscore_description, :text
    remove_column :listings, :rent_cap, :boolean
    remove_column :listings, :lastdatesold, :string
    remove_column :listings, :lastsoldprice, :integer
    remove_column :listings, :yearbuilt, :string
    remove_column :listings, :mls_number, :integer
    remove_column :listings, :url, :string
    remove_column :listings, :images, :text
    rename_column :listings, :street_adress, :address
    rename_column :listings, :rent_zestimate, :rent_estimate

    remove_column :users, :credit_score_bucket, :integer
    remove_column :users, :income, :decimal
  end
end
