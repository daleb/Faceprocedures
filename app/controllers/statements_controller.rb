class StatementsController < ApplicationController
  
  def index
    @statements =  []
    csv_que = CSV::parse(File.open('public/csv/statements.csv', 'r') {|f| f.read })
    fields = csv_que.shift
    @statements = fields.select{|f|f[1]} 
  end
  
end
