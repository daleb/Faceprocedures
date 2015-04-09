class HomeController < ApplicationController
  def index
   # cookies[:computerid] =  nil
    $user_count = 0
    $status=nil
    $userscore = 0
    $round=0
    @from=params[:from]
    session[:computerid]=nil
  end

  def experiment
    
  end
end
