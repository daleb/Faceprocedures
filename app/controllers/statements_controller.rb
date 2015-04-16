class StatementsController < ApplicationController
  
  def index
    @statements =  []
    csv_que = CSV::parse(File.open('public/csv/statements.csv', 'r') {|f| f.read })
    @statements = csv_que.collect{|f| f} 
    $user_data.select{|user| user[:computer_id] == "#{session[:computerid]}"}[0][:status]="On statement page"
  end
  
end
