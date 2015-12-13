class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :loan_type, :integer
    add_column :users, :percent_down_pmt, :integer
    add_column :users, :credit_score_bucket, :integer
    add_column :users, :annual_insurance, :integer
    add_column :users, :acquisition_costs, :integer
    add_column :users, :disposition_costs, :integer
    add_column :users, :annual_maintenance, :integer
    add_column :users, :rent_growth, :integer
    add_column :users, :property_appreciation, :integer
    add_column :users, :income_tax_rate, :integer
    add_column :users, :income, :integer
  end
end
