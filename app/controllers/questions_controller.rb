require "csv"
require "sinatra"
require "uuid"
class QuestionsController < ApplicationController
skip_before_action :verify_authenticity_token, :only => :upload
  def index
    @questions =  []
    csv_que = CSV::parse(File.open('public/csv/questions.csv', 'r') {|f| f.read })
    fields = csv_que.shift
    @questions = csv_que.collect { |record| Hash[*fields.zip(record).flatten ] }
    @questions = @questions.group_by { |d| d["qid"].to_i } 
    #$user_data.select{|user| user[:computer_id] == "#{cookies[:computerid]}"}[0][:status]="Doing Quiz"
  end

  

  def save_quiz_answers
    ### save the quiz answer details
    answers= params.select{|key,val| key.include?("question")}
    ans_collection = [cookies[:computerid]] << answers.collect{|ans|ans[1]}
    file = begin CSV.open("public/csv/quiz_answers_#{Date.today}.csv", "r") rescue nil end
    if file
     CSV.open("public/csv/quiz_answers_#{Date.today}.csv", "a+") do |csv|
      csv << ans_collection.flatten  
     end
    else
     CSV.open("public/csv/quiz_answers_#{Date.today}.csv", "wb") do |csv|
     csv << ans_collection.flatten
    end
    end
    ### save the quiz answer details
    ### perform pairing
    computer_ids= $user_data.collect{|data|data[:computer_id]}.shuffle
    $paired_users=computer_ids.each_slice(2).to_a
    ###
    raise $user_data.inspect
   $user_data.select{|user| user[:computer_id] == "#{cookies[:computerid]}"}[0][:status]="Completed Quiz And Waiting"
   redirect_to participant_path(:from=>"quiz")
   # redirect_to statements_path
  end


  def upload
    uuid = UUID.generate
    
    puts params.inspect


    audio_type = params['audio'].content_type.split("/").last

    File.open("public/uploads/#{uuid}.#{audio_type}", "w") { |f| f.write(File.read(params['audio'].tempfile)) }

    video_type = params['video'].content_type.split("/").last


File.open("public/uploads/#{uuid}.#{video_type}", "w") { |f| f.write(File.read(params['video'].tempfile)) }

    
    `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
    `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

    uuid
  end

end
