class StatsController < ApplicationController
  def show
    
    @to_date = DateTime.now.to_date
    @from_date = Date.new(@to_date.year,@to_date.month)

    @from_date = Date.parse(params[:from_date]) if params[:from_date]
    @to_date = Date.parse(params[:to_date]) if params[:to_date]

    @departments = Department.all
  end
end
