require "user_session"

#require "userdata"
#require "userids"
#require "userlogindata"
require "configdata"
require "userlimit"
#require "participant"
require "controller"
require "connections"
require "user"
#include Datasave


class FaceExperiment
#  def userdata
#    @userdata = Array.new
#  end

  $user_data = Array.new if $user_data.blank?
    (1..24).each do |user|
       $user_data << {:id => user, :computer_id => "nil",:status => "not login" , :round => 0, :connection => "disabled" }
    end

   
 
end




