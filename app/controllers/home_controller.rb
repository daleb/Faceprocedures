class HomeController < ApplicationController
  def index
    session[:status]=nil
    $userscore = 0
    $round=0
    @from=params[:from]
    if session[:computerid]
    reset_session
    $user_count = $user_count - 1
    userdata=begin $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0] rescue session.delete(:computerid) end
    if userdata
     userdata[:status]="not login"
     userdata[:computer_id]=nil
    end
    session.delete(:computerid)
    session.delete(:status)
    end
  end

  def experiment
    
  end
end
