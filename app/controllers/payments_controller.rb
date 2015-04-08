class PaymentsController < ApplicationController
  require "csv"

  def calculate
    option=params["value"]
    statement=params["statement_id"]
    file = begin CSV.open("public/csv/score_details_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/score_details_#{Date.today}.csv", "a+") do |csv|
      csv << [session[:computerid], statement, option]
      end
    else
    CSV.open("public/csv/score_details_#{Date.today}.csv", "wb") do |csv|
    csv << ["computer_id", "statement_id", "option"]
    csv << [session[:computerid], statement, option]
    end  
    end
    render json:{},status: :ok
  end
  
  def results
    @userdata=[]
    current_user = session[:computerid]
    partner_id = $paired_users.select{|pu| pu[0] == current_user || pu[1] == current_user}
    partner_id = partner_id.flatten.delete_if{|id| id == current_user}[0]
    file = begin CSV.open("public/csv/score_details_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.foreach(File.path("public/csv/score_details_#{Date.today}.csv")) do |col|
       if [current_user,partner_id].include?(col[0])
         @userdata << col
       end
    end
    end
    @userdata =  @userdata.group_by{|u|u[1]}
    if $userscore == 0
    @userdata.each do |data|
      currentuser_data = data[1].select{|data| data[0] == current_user}[0][2]
      partner_data= data[1].select{|data| data[0] == partner_id}#[0][2]
      partner_data = partner_data.empty? ? "" : partner_data[0][2]
      if currentuser_data == "split" && partner_data == "split"
        $userscore += 5
      elsif currentuser_data == "takeall" && partner_data == "split"
        $userscore += 10
      elsif currentuser_data == "split" && partner_data == "takeall"
        $userscore += 0
      elsif currentuser_data == "takeall" && partner_data == "takeall"
        $userscore += 0
      end
    end
    end
  end
  
   def calculate_round
    if $round==1
      if (1..4).to_a.sample == 4
      $round = 2
      $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Waiting for Round #{$round}"
      redirect_to participant_path
      else
        $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On Result Page"
        redirect_to results_path
      end
    elsif $round==2
      if (1..16).to_a.sample == 10
       $round = 3
       $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Waiting for Round #{$round}"       
       redirect_to participant_path 
      else
        $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On Result Page"
        redirect_to results_path
      end
    else $round==3
      if (1..64).to_a.sample == 44
       $round = 4
       $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Waiting for Round #{$round}"
       redirect_to participant_path
      else
        $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On Result Page"
        redirect_to results_path
      end
    end
  end
  
end
