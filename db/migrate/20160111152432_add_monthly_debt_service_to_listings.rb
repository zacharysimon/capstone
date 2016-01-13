class AddMonthlyDebtServiceToListings < ActiveRecord::Migration
  
  def change
    add_column :listings, :monthly_debt_service, :integer 
  end
end
