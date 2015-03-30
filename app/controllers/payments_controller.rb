class PaymentsController < ApplicationController
  require "csv"

  def calculate
    option=params["value"]
    statement=params["statement_id"]
    file = begin CSV.open("score_details_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.open("score_details_#{Date.today}.csv", "a+") do |csv|
      csv << [cookies[:computerid], statement, option]
      end
    else
    CSV.open("score_details_#{Date.today}.csv", "wb") do |csv|
    csv << ["computer_id", "statement_id", "option"]
    csv << [cookies[:computerid], statement, option]
    end  
    end
    render json:{},status: :ok
  end
  
end
