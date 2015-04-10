class HomeController < ApplicationController
  def index
   # cookies[:computerid] =  nil
    $user_count = 0
    $status=nil
    $userscore = 0
    $round=0
    @from=params[:from]
    userdata=$user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0]
    userdata[:status]="not login"
    userdata[:computer_id]=nil
    session[:computerid]=nil
  end

  def experiment
    
  end
end
