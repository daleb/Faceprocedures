class HomeController < ApplicationController
  def index
    cookies[:computerid] =  nil
    $user_count = 0
    $status=nil
    $userscore = 0
  end

  def experiment
    
  end
end
