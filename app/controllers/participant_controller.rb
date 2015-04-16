require "csv"
require "uuid"
class ParticipantController < ApplicationController
  require "user"
  require "computerid"
  include Computerid
  respond_to :html, :js, :json
  
  before_filter :create_userdata
  
  
  def index
    if params["coming_from"] == "page_update"
      session[:computerid]=session[:computerid]
      $user_count = $user_count
    else
      ids=$user_data.collect{|ud|ud[:computer_id] if ud[:computer_id]!="nil"}.compact
      if !ids.include?(session[:computerid])
        user=$user_data.select{|ud|ud[:computer_id]=="nil"}.first
          user[:computer_id] = "#{session[:computerid]}"
          user[:status] = "online"
          user_status="online"
      end
    end
    
    @user = $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}
    if (params["from"]=="picked_action" || params["from"]=="Waiting after emotion survey")  
      @page="waiting"
    end
    if @user[0] && @user[0][:connection] == "enabled" && $experiment_status!="start" && params["from"] != "adjust_page" && session[:status] !="adjusted"
      @page = "adjust webcam"
      @from="adjsut_cam"
      user_status = "Adjusting Camera"
      session[:status] ="adjusted"
    elsif $experiment_status == "start" && params["from"]!="quiz" && $round==2
      @page = "quiz"
    else
      if params["from"]!="picked_action" && params["from"]!="Waiting after emotion survey"
      @page = "waiting"
      user_status = params["from"]=="quiz" ? @user[0][:status] : "On waiting screen"
      end
    end
    
    if  params["from"] == "adjust_page"
      @page = "waiting"
      user_status = "On waiting screen"
    end
    if (params["from"]!="picked_action" && (($user_count > 0 && $user_data.select{|user|user[:status]=="Completed Quiz And Waiting"}.length == $user_count) || ($user_count > 0 && $user_data.select{|user|user[:status]=="Waiting for Round 2"}.length == $user_count)))
       @page = "statement" 
    elsif ($user_count > 0 && $user_data.select{|user|user[:status]=="Picked Action And Waiting"}.length == $user_count)
       @page= "results"
    elsif ($user_count > 0 && $user_data.select{|user|user[:status]=="Completed Emotion Survey And Waiting"}.length == $user_count)
       @page= "calulate_round"
    elsif ($user_count > 0 && $user_data.select{|user|user[:status].include?("Waiting for Round")}.length == $user_count)
      asdsadas
       @page= "statement"
    end
    
    if params["from"]!="picked_action" && params["from"]!="Waiting after emotion survey"
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]=user_status ? user_status : "not login"
    end
    
    respond_to do|format|
			format.js
      format.html
      format.json
		end
  end

 def sample_video
    @from=params["from"]
 end
 
 def save_survey_results
   option=params["value"]
   file = begin CSV.open("public/csv/survey_results_#{Date.today}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/survey_results_#{Date.today}.csv", "a+") do |csv|
      csv << [session[:computerid], $round, option]
      end
    else
    CSV.open("public/csv/survey_results_#{Date.today}.csv", "wb") do |csv|
    csv << ["computer_id", "round", "option"]
    csv << [session[:computerid], $round, option]
    end  
    end
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Completed Emotion Survey And Waiting"
    render json:{},status: :ok
 end

def save
  uuid = UUID.generate
  video_type ="webm"# params['video'].content_type.split("/").last
  video_name="#{session[:computerid]}_emotion_#{$round}.#{video_type}"
  File.open("public/uploads/#{video_name}", "w") { |f| f.write(File.read(params['video-blob'].tempfile)) }

    
    `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
    `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

    uuid
end

def get_information
  $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On Exit Survey!"
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

 def create_userdata
    if session[:computerid].blank? && !request.url.split("/").include?("control")
      puts "i am creating #{session[:computerid]}"
      puts session[:computerid] 
     mycomputerid = genseratecomputerid()
    end
  end

 
end
