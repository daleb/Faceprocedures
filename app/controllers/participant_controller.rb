require "csv"
require "uuid"
class ParticipantController < ApplicationController
  require "user"
  respond_to :html, :js, :json
  def index
    unless  $user_data.inject([]){|arr,h| arr << h[:computer_id]}.include?("#{session[:computerid]}")
      $user_data.select do |user|
        if user[:id] == $user_count
          user[:computer_id] = "#{session[:computerid]}"
          user[:status] = "online"
          user_status="online"
        end
      end
    end
    
    @user = $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}
    if @user[0] && @user[0][:connection] == "enabled" && $experiment_status!="start" && params["from"] != "adjust_page" && $status !="adjusted"
      @page = "adjust webcam"
      user_status = "Adjusting Camera"
    elsif $experiment_status == "start" && params["from"]!="quiz"
      @page = "quiz"
      user_status = "Doing Quiz"
    else
      @page = "waiting"
      user_status = params["from"]=="quiz" ? @user[0][:status] : "On waiting screen"
    end
    
    if  params["from"] == "adjust_page"
      @page = "waiting"
      user_status = "On waiting screen"
    end
    #raise [$user_data.select{|user|user[:status]=="Completed Quiz And Waiting"}.length , $user_count].inspect
    if 1==1#$user_data.select{|user|user[:status]=="Completed Quiz And Waiting"}.length == $user_count
       @page = "statement"
       user_status = "On statement page"
    end
    
    $user_data.select do |user|
        if user[:id] == $user_count
          user[:computer_id] = "#{session[:computerid]}"
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

def save
  uuid = UUID.generate
  video_type ="webm"# params['video'].content_type.split("/").last
  video_name="#{session[:computerid]}_emotion.#{video_type}"
  File.open("public/uploads/#{video_name}", "w") { |f| f.write(File.read(params['video-blob'].tempfile)) }

    
    `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
    `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

    uuid
end

def get_information
  
end

def save_user_information
  name,age,firstlanguage,sex,fluency = params["user_name"],params["user_age"].to_i,params["user_language"],params["user_gender"],params["user_fluency"]
  file = begin CSV.open("public/csv/user_information.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/user_information.csv", "a+") do |csv|
      csv << [name,age,firstlanguage,sex,fluency]
      end
    else
      CSV.open("public/csv/user_information.csv", "wb") do |csv|
      csv << [name,age,firstlanguage,sex,fluency]
      end  
    end
    redirect_to root_path(:from=>"exit")
end

 
end
