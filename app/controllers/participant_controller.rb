require "csv"
class ParticipantController < ApplicationController
  require "user"
  respond_to :html, :js, :json
  def index
    unless  $user_data.inject([]){|arr,h| arr << h[:computer_id]}.include?("#{cookies[:computerid]}")
      $user_data.select do |user|
        if user[:id] == $user_count
          user[:computer_id] = "#{cookies[:computerid]}"
          user[:status] = "online"
          user_status="online"
        end
      end
    end
    @user = $user_data.select{|user| user[:computer_id] == "#{cookies[:computerid]}"}
    if @user[0][:connection] == "enabled" && $experiment_status!="start" && params["from"] != "adjust_page" && $status !="adjusted"
      @page = "adjust webcam"
      user_status = "Adjusting Camera"
    elsif $experiment_status == "start"
      @page = "quiz"
      user_status = "Doing Quiz"
    else
      @page = "waiting"
      user_status = "On waiting screen"
    end
    
    if  params["from"] == "adjust_page"
      @page = "waiting"
      user[:status] = "On waiting screen"
    end
    
    $user_data.select do |user|
        if user[:id] == $user_count
          user[:computer_id] = "#{cookies[:computerid]}"
          user[:status] = user_status ? user_status : "not login"
        end
      end
    
    respond_to do|format|
			format.js
      format.html
      format.json
		end
  end

 def sample_video
   
 end



 
end
