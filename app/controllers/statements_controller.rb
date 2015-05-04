class StatementsController < ApplicationController
  
  def index
    @current_controller = controller_name
    @statements =  []
    csv_que = CSV::parse(File.open('public/master/statements.csv', 'r') {|f| f.read })
    @statements = csv_que.collect{|f| f}[$round]
  end
  
end
