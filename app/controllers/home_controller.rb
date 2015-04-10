class HomeController < ApplicationController
  def index
    session[:status]=nil
    $userscore = 0
    $round=0
    @from=params[:from]
    if session[:computerid]
    $user_count = $user_count - 1
    userdata=$user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0]
    userdata[:status]="not login"
    userdata[:computer_id]=nil
    session[:computerid]=nil
    session[:status]=nil
    end
  end

  def experiment
    
  end
end
