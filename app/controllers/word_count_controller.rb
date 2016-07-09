class WordCountController < ApplicationController
  before_filter :check_params, :only => [:upload]
  
  def index
    render html:'/index.haml'
  end
  
  
  #calculate total lines,words and characters in file
  def upload
    begin  
      file = params[:file].open 
      @file_reading = true
      @file_details = {
                        lines: 0,
                        words: 0,
                        characters: 0
                      }
      file.each_line do |line|
        @file_details[:lines] += 1
        words = line.split
        words.each  do  |w|
          @file_details[:words] += 1
          @file_details[:characters] += w.length
        end
      end
    rescue Exception => e
      @file_reading = false
      Rails.logger.error(e.message)
    end  
  end  
  
  private 
  
  def check_params
    if params[:file].blank? ||  params[:file].content_type != "text/plain"
      @file_reading = false
      render html:'/upload.haml' and return
    end
  end
  
  
  
end