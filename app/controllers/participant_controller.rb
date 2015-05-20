require "csv"
require "uuid"
require 'fileutils'
class ParticipantController < ApplicationController
  require "computerid"
  include Computerid
  respond_to :html, :js, :json
  before_filter :create_userdata, :only=>[:index]
  
  def index
    @current_controller = controller_name
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
    elsif $experiment_status == "start" && params["from"]!="quiz" && session[:quiz_status]!="Quiz Completed"
      @page = "quiz"
      session[:quiz_status]="Quiz Completed"
    else
      if params["from"]!="picked_action" && params["from"]!="Waiting after emotion survey"
      @page = "waiting"
      if params["from"]!="Waiting after emotion survey" && @user[0][:status]!="Completed Emotion Survey And Waiting"
      user_status = params["from"]=="quiz" ? @user[0][:status] : "On waiting screen"
      end
      end
    end
    
    if  params["from"] == "adjust_page"
      @page = "waiting"
      user_status = "On waiting screen"
    end
    if (params["from"]!="picked_action" && (($user_count > 0 && $user_data.select{|user|user[:status]=="Completed Quiz And Waiting"}.length == $user_count) || ($user_count > 0 && $user_data.select{|user|user[:status]=="Waiting for Round 2"}.length == $user_count)))
      @page = "statement"
      #Dir.chdir("public/csv"){
      #@answers = Dir.glob("quiz_answers_#{$filestamp}.csv")
       #    }
    elsif ($user_count > 0 && $user_data.select{|user|user[:status]=="Picked Action And Waiting"}.length == $user_count && $recording_count == $user_count)
       @page= "results"
    elsif ($user_count > 0 && $user_data.select{|user|user[:status]=="Completed Emotion Survey And Waiting"}.length == $user_count)
      if session[:computerid]=="PART-001"
      $result =calculate_round
       if $result == "exit_poll"
         #$user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On Result Page"
         $user_data.select{|u|u[:computer_id]!="nil"}.each do |user|
           user[:status]="On Exit Survey!"
         end
         @page= "results"
         @from="exit_poll"
       elsif $result.class == Fixnum
         #$user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Waiting for Round #{$result}"
         $user_data.select{|u|u[:computer_id]!="nil"}.each do |user|
           user[:status]="Waiting for Round #{$result}"
         end
         @page= "statement"
       end
       end
     elsif ($user_count > 0 && $user_data.select{|user|user[:status].include?("On Exit Survey!")}.length == $user_count && $result=="exit_poll")
       @page= "results"
       @from="exit_poll"
     elsif ($user_count > 0 && $user_data.select{|user|user[:status].include?("Waiting for Round #{$round}")}.length == $user_count)
       @page= "statement"
    end
    
    if params["from"]!="picked_action" && params["from"]!="Waiting after emotion survey"
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]=user_status ? user_status : "not login"
    end
    
     if params["from"]=="vdo"
      if $user_count == $feedback_recording
      @page = "result_after_feedback"
      else
      @page = "waiting"
      end
    end
    
    respond_to do|format|
			format.js
      format.html
      format.json
		end
  end

 def sample_video
    @from=params["from"]
    if @from=="result"
    @userdata=[]
    session[:recording_for]="feedback_recording"
    ## payment calc --start
    current_user = session[:computerid]
    partner_id = $paired_users.select{|pu| pu[0] == current_user || pu[1] == current_user}
    partner_id = partner_id.flatten.delete_if{|id| id == current_user}[0]
    file = begin CSV.open("public/csv/statement_results_#{$filestamp}.csv", "r") rescue nil end
    if file
      CSV.foreach(File.path("public/csv/statement_results_#{$filestamp}.csv")) do |col|
       if [current_user,partner_id].include?(col[0]) && col[1]== $round.to_s
         @userdata << col
       end
    end
    end
    @userdata = @userdata.group_by{|u|$round}
    if session[$round].nil?
    session[$round]=0
    @userdata.each do |data|
      currentuser_data = data[1].select{|data| data[0] == current_user}[0][2]
      session[:myoption]=currentuser_data
      partner_data= data[1].select{|data| data[0] == partner_id}[0][2]
      session[:partneroption]=partner_data
      if currentuser_data == "split" && partner_data == "split"
        session[$round] += 5
      elsif currentuser_data == "take all" && partner_data == "split"
        session[$round] += 10
      elsif currentuser_data == "split" && partner_data == "take all"
        session[$round] += 0
      elsif currentuser_data == "take all" && partner_data == "take all"
        session[$round] += 0
      end
    end
    end

      ## payment calc --end
    else
      session[:recording_for]="statement_recording"
    end
 end
 
 def save_survey_results
   options=params["value"]
   file = begin CSV.open("public/csv/survey_results_#{$filestamp}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/survey_results_#{$filestamp}.csv", "a+") do |csv|
      i=0
      options.each do |option|
       csv << [session[:computerid], $round,i+=1, option]
      end
      end
    else
    CSV.open("public/csv/survey_results_#{$filestamp}.csv", "wb") do |csv|
    csv << ["computer_id", "round", "statement id","option"]
    i=0
    options.each do |option|
     csv << [session[:computerid], $round,i+=1, option]
    end
    end  
    end
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="Completed Emotion Survey And Waiting"
    render json:{},status: :ok
 end

def save
 # uuid = UUID.generate
  video_type ="webm"
  participant_id=params["part_id"]
  recording_for = params["recording_for"]
  recording_for == "statement_recording" ? $recording_count+=1 : $feedback_recording+=1 
  video_name="#{participant_id}_#{recording_for}_for_round_#{$round}_#{$filestamp}.#{video_type}"
  output_file = File.open("public/uploads/#{video_name}", "w")
  FileUtils.copy_stream(params['video-blob'].tempfile, output_file)
  #File.open("public/uploads/#{video_name}", "w") { |f| f.write(File.read(params['video-blob'].tempfile)) }

    
   # `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
   # `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

   # uuid
    render json:{},status: :ok
end

def get_information
  
end

def save_user_information
  name,age,firstlanguage,sex,fluency = params["first_name"].concat(" " + params["last_name"]).to_s,params["user_age"].to_i,params["user_language"],params["user_gender"],params["user_fluency"]
  session[:part_name]=name
  file = begin CSV.open("public/csv/user_information_#{$filestamp}.csv", "r") rescue nil end
    if file
      CSV.open("public/csv/user_information_#{$filestamp}.csv", "a+") do |csv|
      csv << [session[:computerid],name,age,firstlanguage,sex,fluency]
      end
    else
      CSV.open("public/csv/user_information_#{$filestamp}.csv", "wb") do |csv|
      csv << ["Part_id", "Name", "Age","Language","Sex","Fluency"]
      csv << [session[:computerid],name,age,firstlanguage,sex,fluency]
      end  
    end
    redirect_to root_path(:from=>"exit")
end

 def create_userdata
    if session[:computerid].blank? && !request.url.split("/").include?("control") && $experiment_status!="start"
      puts "i am creating #{session[:computerid]}"
      puts session[:computerid] 
     mycomputerid = genseratecomputerid()
    end
  end
  
  def calculate_round
    $result=nil
    if $round==1
      $round = 2
      $recording_count = 0
      $feedback_recording = 0
      session[$round]=nil
      return $round
    elsif $round==2
      if (1..4).to_a.sample == 4
      $round = 3
      $recording_count = 0
      $feedback_recording = 0
      session[$round]=nil
      return $round
      else
       return "exit_poll"
      end
    elsif $round==3
      if (1..16).to_a.sample == 10
       $round = 4
       $recording_count = 0
       $feedback_recording = 0
       session[$round]=nil
       return $round 
      else
        return "exit_poll"
      end
    else $round==4
      if (1..64).to_a.sample == 44
       $round = 5
       $recording_count = 0
       $feedback_recording = 0
       session[$round]=nil
      return $round
      else
        return "exit_poll"
      end
    end
  end

 
end
