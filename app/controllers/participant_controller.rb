require "csv"
class ParticipantController < ApplicationController
  require "user"
  respond_to :html, :js, :json
  def index
     unless  $user_data.inject([]){|arr,h| arr << h[:computer_id]}.include?("#{cookies[:computerid]}")
      $user_data.select do |user|
        if user[:id] == $user_count
          user[:computer_id] = "#{cookies[:computerid]}"
          user[:status] = "online"
        end
      end
    end
   
    if $user_data.select{|user| user[:connection] == "enabled"}
      @page = "waiting"
    else
      @page = "quiz"
    end
    respond_to do|format|
			format.js
      format.html
      format.json
		end
  end












  #  @userdata = Array.new(24)



  #    def authorize()
  #    ##############################################################################
  #    @mycomputerid = getcomputerid()
  #    validuser = validateuser()
  #    if validuser
  #      @mysession = getmysession()
  #      @myuserid =  @mysession.nil? ?  0:@mysession[:myuserid]
  #      @mygroup =  @mysession.nil? ?  0:@mysession[:group]
  #    else
  #      Rails.logger.info("*** Invalid User Request Rejected")
  #      redirect_to "/login"
  #    end
  #
  #    #       Rails.logger.warn("instantiate_controller_and_action_names - @myuserid = " + @myuserid.to_s)
  #
  #  end
  #
  #      def validateuser()
  #  ##############################################################################
  #    validuser = false
  #    computerid = getcomputerid()
  #    sessionid = getmysessionid()
  #
  #        @userconnections = Connections.new()
  #
  #    validuser = $gExperiment.userconnections.valid(sessionid, computerid)
  #    unless validuser
  #      Rails.logger.warn("Failed validation of computerid = [" + computerid.inspect + "]    sessionid = [" + sessionid.inspect + "]")
  #    end
  #    return validuser
  #  end



end
