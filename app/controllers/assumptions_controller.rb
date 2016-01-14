class AssumptionsController < ApplicationController

  def index
  end

  def show
  end

  def edit
    
  end

  def update
    current_user.update(
      first_name: params[:input_first_name],
      last_name: params[:input_last_name],
      percent_down_pmt: params[:input_percent_down_pmt],
      loan_type: params[:input_loan_type],
      acquisition_costs: params[:input_acquisition_costs],
      disposition_costs: params[:input_disposition_costs],
      annual_maintenance: params[:input_annual_maintenance],
      annual_insurance: params[:input_annual_insurance],
      rent_growth: params[:input_rent_growth],
      property_appreciation: params[:input_property_appreciation],
      income_tax_rate: params[:input_income_tax_rate],
      )

    flash[:success] = "Profile was successfully updated!"
    redirect_to '/assumptions'
  end

end
