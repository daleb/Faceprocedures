require "csv"
class QuestionsController < ApplicationController
  def index
    @questions =  []
    csv_que = CSV::parse(File.open('public/csv/quiz/questions.csv', 'r') {|f| f.read })
    fields = csv_que.shift
    @questions = csv_que.collect { |record| Hash[*fields.zip(record).flatten ] }
    @questions = @questions.group_by { |d| d["qid"].to_i }
  end



  def save_quiz_answers
#    redirect_to root_path
  end
  
end