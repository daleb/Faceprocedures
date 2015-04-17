class HomeController < ApplicationController
  def index
    @total_score = begin session["1"] + (session["2"].nil? ? 0 : session["2"])   + (session["3"].nil?? 0 : session["3"]) + (session["4"].nil?? 0 : session["4"]) + (session["5"].nil? ? 0 : session["5"]) rescue 0 end
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
