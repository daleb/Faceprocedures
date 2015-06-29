class ApplicationController < ActionController::Base
  skip_before_filter  :verify_authenticity_token
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  STOP = "stop"
  START = "start"
  RESET = "reset"
  $control_id = "admin"
  $control_password = "qazplm123"
  $valid_control = false if $valid_control.nil?
  $user_count = 0 if $user_count.nil?
  $userscore = 0 if $userscore.nil?
  $round = 0 if $round.nil?
  $experiment_status = STOP if $experiment_status.nil?
  $quiz_status="" if $quiz_status.nil?
  $paired_users=[] if $paired_users.nil?
  $Autoplay = false

  # The following is use by the fileupload at the end
  $limit
  $uploadcompleted = false if $uploadcompleted.nil?
  $partsready = Hash.new if $partsready.nil?
  $uploadready = false if $uploadready.nil?
  $processing = ['Part-000',false] if $processing.nil?
  $partcount = 2 if $partcount.nil?
  $uploadcount = 0 if $uploadcount.nil?


  # Adde the file stamp lock the file name to a min.  Since the
  # previous implementation was getting the time evertime the file
  # was accessed.  It will be set at the start of an experiment so it
  # be accurate to the min for each experiment.
  $filestamp = ""

  require "faces"



  def initialize()
    super()
       Rails.logger.info("ApplicationController Initialized = " )
    $gInitApp = initapplication() unless $gInitApp == true
  end

  def initapplication()
    $gConfigData = ConfigData.new if $gConfigData.nil?
    $gUserLimitData = UserLimit.new if $gUserLimitData.nil?
    $gExperiment = FaceExperiment.new()
  end

  
end
