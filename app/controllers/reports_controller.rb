class ReportsController < ApplicationController
  def department_ips
    @deps = Department.includes(:ips)

    respond_to do |format|
      format.html # by_department.html.erb
#      format.json { render json: @deps }
    end
  end

end
