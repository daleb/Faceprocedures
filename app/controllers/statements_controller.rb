class StatementsController < ApplicationController
  
  def index
    @statements =  []
    csv_que = CSV::parse(File.open('public/csv/statements.csv', 'r') {|f| f.read })
    @statements = csv_que.collect{|f| f}[$round]
  end
  
end
