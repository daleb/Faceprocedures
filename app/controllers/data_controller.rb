class DataController < ApplicationController
  
  def index
    @path = "csv"
    Dir.chdir("public/csv"){
      @answers = Dir.glob("*answer*")
      @answers.sort!.reverse!
   
    }
    @rowcount = @answers.length - 1
    @rowcount = 0 if @rowcount < 0
  end
  
  def download_videos
    @path = "uploads"
    Dir.chdir("public/uploads"){
      @emotions = Dir.glob("*emotion*")
      @emotions.sort!.reverse!
    }
    @rowcount = @emotions.length - 1
    @rowcount = 0 if @rowcount < 0    
  end
  
  def download_statement_answers
    @path = "csv"
    Dir.chdir("public/csv"){
      @statements = Dir.glob("*score_details*")
      @statements.sort!.reverse!
    }
    @rowcount = @statements.length - 1
    @rowcount = 0 if @rowcount < 0    
  end
  
  def get_pairing_details
    
  end
 
end
