require 'csv'
class ControlController < ApplicationController

  before_filter :check_valid_control, :except => [:login, :validatecontroller]
  respond_to :html, :js, :json
  
  def index
    
    respond_to do|format|
			format.js
      format.html
      format.json
		end
  end

  def login
    
  end

  def validatecontroller
    if params[:control_login].present? and  params[:control_password].present?
      if params[:control_login] == $control_id and params[:control_password] == $control_password
        $valid_control = true
        redirect_to control_path
      else
        redirect_to control_login_path
      end
    else
      redirect_to control_login_path
    end
  end

  def changetime
    newtime = params[:time].to_i
    $gConfigData.newtime(newtime.to_i)
    render json:{time: $gConfigData.time},status: :ok
  end


  def export_sample_csv
    csv_string = CSV.generate do |csv|
      csv << ["qid", "ref", "data", "answer"]
    end
    send_data csv_string,
      :type => 'text/csv',
      :filename => 'questions.csv',
      :disposition => 'attachment'
  end


  def change_status
    computer_id  = params[:computer_id]
    $user_data.select do |user|
      if user[:computer_id] == computer_id
        user[:conntection] = "enabled"
      end
    end
    render json:{},status: :ok
  end


  def start_experiment
    $experiment_status = params[:status]
    render json:{},status: :ok
  end

  
end
