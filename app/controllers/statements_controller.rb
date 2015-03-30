class StatementsController < ApplicationController
  
  def index
    @statements =  []
    csv_que = CSV::parse(File.open('public/csv/statements.csv', 'r') {|f| f.read })
   # fields = csv_que.shift
    @statements = csv_que.collect{|f| f} 
  end
  
end
