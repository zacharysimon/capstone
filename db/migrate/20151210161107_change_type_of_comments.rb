class ChangeTypeOfComments < ActiveRecord::Migration
  def change
    change_column :users, :percent_down_pmt, :decimal, :precision => 10, :scale => 4
    change_column :users, :annual_insurance, :decimal, :precision => 10, :scale => 2
    change_column :users, :acquisition_costs, :decimal, :precision => 10, :scale => 2
    change_column :users, :disposition_costs, :decimal, :precision => 10, :scale => 2
    change_column :users, :annual_maintenance, :decimal, :precision => 10, :scale => 3
    change_column :users, :rent_growth, :decimal, :precision => 10, :scale => 4
    change_column :users, :property_appreciation, :decimal, :precision => 10, :scale => 4
    change_column :users, :income_tax_rate, :decimal, :precision => 10, :scale => 4
    change_column :users, :income, :decimal, :precision => 15, :scale => 2

  end
end
