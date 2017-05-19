class PingLogsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @pings = PingLog.order(created_at: :desc).limit(1000)
  end

  def start_job
    ApplicationJob.perform_later (params[:ip])
    redirect_to ping_logs_path
  end

  def clear
    PingLog.all.destroy_all
    redirect_to ping_logs_path
  end

  def data_chart
    query = PingLog.select(:ping, :created_at).where("ip like '#{params[:ip]}'").where('created_at >= :one_hour_ago', :one_hour_ago => 6.hour.ago)
    array = query.map do |pinglog|
      [pinglog.created_at.to_f * 1000, pinglog.ping]
    end
    respond_to do |format|
      format.json { render json: array }
    end
  end
end
