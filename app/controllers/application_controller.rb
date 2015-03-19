class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  STOP = "stop"
  START = "start"
  RESET = "reset"
  $control_id = "admin"
  $control_password = "qazplm123"
  $valid_control = false if $valid_control.nil?
  $user_count = 0 if $user_count.nil?
  $experiment_status = STOP if $experiment_status.nil?

  require "computerid"
  include Computerid
  require "faces"


  before_filter :create_userdata
  
  def check_control_login

  end

  def check_valid_control
    if  $valid_control == true
      return true
    else
      redirect_to control_login_path
    end
  end





  def initialize()
    super()
       Rails.logger.info("ApplicationController Initialized = " )
    $gInitApp = initapplication() unless $gInitApp == true
  end

  def initapplication()
    $gConfigData = ConfigData.new if $gConfigData.nil?
    $gExperiment = FaceExperiment.new()
  end




  def getmysessionid
    sessionid = request.session_options[:id].to_s.strip
    return sessionid
  end




  def authorize()
    @mycomputerid = getcomputerid()
    validuser = validateuser()
   
    if validuser
      @mysession = getmysession()
      @myuserid =  @mysession.nil? ?  0:@mysession[:myuserid]
      @mygroup =  @mysession.nil? ?  0:@mysession[:group]
    else
      Rails.logger.info("*** Invalid User Request Rejected")
      redirect_to "/login"
    end

    #       Rails.logger.warn("instantiate_controller_and_action_names - @myuserid = " + @myuserid.to_s)

  end

  def getmysession()
    ##############################################################################
    #    Rails.logger.debug("def " + __method__.to_s + ")
    yoursession = nil
    mysessionid = getmysessionid()
    if Rails.env == "development"
      yoursession = $gExperiment.sessions.mysession(mysessionid)
    else
      mycomputerid = getcomputerid()
      #      Rails.logger.warn("mycomputerid = " + mycomputerid.inspect)
      yoursession = $gExperiment.sessions.mysession(mysessionid)
    end
    Rails.logger.warn("mycomputerid = " + mycomputerid.inspect) if yoursession.nil?
    Rails.logger.warn("Returning Nil session") if yoursession.nil?
    return yoursession
  end



  def create_userdata
    if cookies[:computerid].blank?
     mycomputerid = genseratecomputerid()
      $user_count =  $user_count + 1
    end
  end


    

 


  
end
