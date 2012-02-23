class StatsController < ApplicationController
  def show
    
    @to_date = DateTime.now.to_date
    @from_date = Date.new(@to_date.year,@to_date.month)

    @from_date = Date.parse(params[:from_date]) if params[:from_date]
    @to_date = Date.parse(params[:to_date]) if params[:to_date]

    @inbounds_by_id = Ip.joins(:inbounds).where("ts >= ? AND ts < ?",@from_date,@to_date).group(:department_id).sum(:bytes)
    @outbounds_by_id = Ip.joins(:outbounds).where("ts >= ? AND ts < ?",@from_date,@to_date).group(:department_id).sum(:bytes)

    @departments = Department.all

    collect_total_bytes
  end

  private

  def collect_total_bytes
    @total_inbounds_by_id = {}
    @total_outbounds_by_id = {}

    @departments.each do |d|
      cur = d
      in_bytes = @inbounds_by_id[d.id] || 0
      out_bytes = @outbounds_by_id[d.id] || 0
      while cur
        @total_inbounds_by_id[cur.id] = 0 if !@total_inbounds_by_id[cur.id]
        @total_inbounds_by_id[cur.id] += in_bytes

        @total_outbounds_by_id[cur.id] = 0 if !@total_outbounds_by_id[cur.id]
        @total_outbounds_by_id[cur.id] += out_bytes

        cur = cur.parent
      end
    end
  end
end
