require 'csv'
class ControlController < ApplicationController

  #before_filter :check_valid_control, :except => [:login, :validatecontroller]
  respond_to :html, :js, :json
  
  def index
    respond_to do|format|
			#format.js
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
        user[:connection] = "active"
      end
    end
    render json:{},status: :ok
  end


  def start_experiment
    $experiment_status = params[:status]
    if ["stop","reset"].include?(params[:status])
      session[:status] = nil
      $user_data.each do |user|
       user[:connection]="disabled"
      end
    end
    if $experiment_status=="start"
      $round=1
    end
    render json:{},status: :ok
  end
  
  def save_upload
    name = params[:upload][:file].original_filename
    directory = "public/csv"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }
    flash[:notice] = "File uploaded"
    redirect_to control_path
  end
  
  def change_enable_status
    if params["status"] == "enable"
      $user_data.select do |user|
        user[:connection] = "enabled"
      end      
      session[:status]= nil
    end
    redirect_to control_path
  end
  
  def changelimit
    newlimit = params[:limit].to_i
    $limit = $gUserLimitData.newlimit(newlimit.to_i)
    render json:{limit: $gUserLimitData.limit},status: :ok
  end
  
  def pageupdate
    userdata=$user_data.group_by{|user|user[:computer_id]}.delete_if{|u|u.nil? || !u.include?("PART")}
    userdata.each do |data|
      if data[1].length > 1
        (2 .. data[1].length.to_i).to_a.each do |ext_row|
        id=data[1][ext_row - 1][:id]
        $user_data[id - 1][:computer_id]=nil
        $user_data[id - 1][:status]="not login"
        end
      end
    end
    render :layout=>false
  end

  
end
