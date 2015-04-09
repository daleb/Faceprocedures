class HomeController < ApplicationController
  def index
   # cookies[:computerid] =  nil
    $user_count = 0
    $status=nil
    $userscore = 0
    $round=0
    @from=params[:from]
  end

  def experiment
    
  end
end
