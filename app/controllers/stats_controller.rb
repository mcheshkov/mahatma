class StatsController < ApplicationController
  def show
    set_dates

    @departments = Department.all
  end

  def show_department
    set_dates

    @department = Department.find(params[:department_id])
  end

  private
  def set_dates
    @to_date = DateTime.now.to_date
    @from_date = Date.new(@to_date.year,@to_date.month)

    @from_date = Date.parse(params[:from_date]) if params[:from_date]
    @to_date = Date.parse(params[:to_date]) if params[:to_date]
  end
end
