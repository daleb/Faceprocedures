require "csv"
require "uuid"
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
    if @user[0] && @user[0][:connection] == "enabled" && $experiment_status!="start" && params["from"] != "adjust_page" && $status !="adjusted"
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

def save
 
  uuid = UUID.generate
  video_type ="webm"# params['video'].content_type.split("/").last

File.open("public/uploads/#{uuid}.#{video_type}", "w") { |f| f.write(File.read(params['video-blob'].tempfile)) }

    
    `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
    `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

    uuid
    
    sdfsdfsdfsdf
  raise params.inspect
   name = params["video-filename"]#.original_filename
    directory = "public/csv"
    path = File.join(directory, name)
   File.open(path, 'wb') do |f|
    f.write params["video-blob"]
  end
    flash[:notice] = "File uploaded"
  params.save!
end

def get_information
  
end

def save_user_information
  age,firstlanguage,sex,fluency = params["age"].to_i,params["firstlanguage"],params["sex"],params["fluency"]
  file = begin CSV.open("public/csv/user_information.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/user_information.csv", "a+") do |csv|
      csv << [age,firstlanguage,sex,fluency]
      end
    else
      CSV.open("public/csv/user_information.csv", "wb") do |csv|
      csv << [age,firstlanguage,sex,fluency]
      end  
    end
    redirect_to root_path
end
 
end
