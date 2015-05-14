class PaymentsController < ApplicationController
  require "csv"

  def calculate
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On statement page"
    option=params["value"]
    file = begin CSV.open("public/csv/statement_results_#{$filestamp}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/statement_results_#{$filestamp}.csv", "a+") do |csv|
      csv << [session[:computerid], $round, option]
      end
    else
    CSV.open("public/csv/statement_results_#{$filestamp}.csv", "wb") do |csv|
    csv << ["computer_id", "round", "option"]
    csv << [session[:computerid], $round, option]
    end  
    end
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Picked Action And Waiting"
    render json:{},status: :ok
  end
  
  def results
    @from=params["from"]
    @survey =  []
    @flag=params["flag"]
    csv_que = CSV::parse(File.open('public/master/survey.csv', 'r') {|f| f.read })
    @survey = csv_que.collect{|f| f[1] if f[0].to_i==$round.to_i}.compact
  end
  
end
