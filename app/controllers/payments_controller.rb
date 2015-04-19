class PaymentsController < ApplicationController
  require "csv"

  def calculate
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On statement page"
    option=params["value"]
    file = begin CSV.open("public/csv/score_details_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/score_details_#{Date.today}.csv", "a+") do |csv|
      csv << [session[:computerid], $round, option]
      end
    else
    CSV.open("public/csv/score_details_#{Date.today}.csv", "wb") do |csv|
    csv << ["computer_id", "round", "option"]
    csv << [session[:computerid], $round, option]
    end  
    end
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Picked Action And Waiting"
    render json:{},status: :ok
  end
  
  def results
    @from=params["from"]
    @userdata=[]
    @survey =  []
    @flag=params["flag"]
    csv_que = CSV::parse(File.open('public/csv/survey.csv', 'r') {|f| f.read })
    @survey = csv_que.collect{|f| f}[$round - 1]
    current_user = session[:computerid]
    partner_id = $paired_users.select{|pu| pu[0] == current_user || pu[1] == current_user}
    partner_id = partner_id.flatten.delete_if{|id| id == current_user}[0]
    file = begin CSV.open("public/csv/score_details_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.foreach(File.path("public/csv/score_details_#{Date.today}.csv")) do |col|
       if [current_user,partner_id].include?(col[0]) && col[1]== $round.to_s
         @userdata << col
       end
    end
    end
    @userdata = @userdata.group_by{|u|$round}
    if session[$round].nil?
    session[$round]=0
    @userdata.each do |data|
      currentuser_data = data[1].select{|data| data[0] == current_user}[0][2]
      partner_data= data[1].select{|data| data[0] == partner_id}[0][2]
      if currentuser_data == "split" && partner_data == "split"
        session[$round] += 5
      elsif currentuser_data == "takeall" && partner_data == "split"
        session[$round] += 10
      elsif currentuser_data == "split" && partner_data == "takeall"
        session[$round] += 0
      elsif currentuser_data == "takeall" && partner_data == "takeall"
        session[$round] += 0
      end
    end
    end
  end
  
end
