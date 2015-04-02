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
 
end
