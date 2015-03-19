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
  end

  

  def save_quiz_answers
    ### save the quiz answer details
    redirect_to statements_path
  end


  def upload
    uuid = UUID.generate
    
    puts params.inspect


    audio_type = params['audio'].content_type.split("/").last

#    audio_file = File.new("public/uploads/#{uuid}.#{audio_type}", "w")


#    File.open("public/uploads/#{uuid}.#{audio_type}", "w") do |f|
#      f.write(params['audio'].tempfile.read)
#    end


    File.open("public/uploads/#{uuid}.#{audio_type}", "w") { |f| f.write(File.read(params['audio'].tempfile)) }

    video_type = params['video'].content_type.split("/").last

#     video_file = File.new("uploads/#{uuid}.#{video_type}", "w")

#    File.open("public/uploads/#{uuid}.#{video_type}", "w") do |f|
#      f.write(params['video'].tempfile.read)
#    end
File.open("public/uploads/#{uuid}.#{video_type}", "w") { |f| f.write(File.read(params['video'].tempfile)) }

    
    `ffmpeg -i public/uploads/#{uuid}.webm public/uploads/#{uuid}.mp4`
    `ffmpeg -i public/uploads/#{uuid}.mp4 -i public/uploads/#{uuid}.wav -c:v copy -c:a aac -strict experimental public/videos/#{uuid}.mp4`

    uuid
  end

end
