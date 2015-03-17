################################################################################
class UserSession
  ##############################################################################

  ################################################################################
  def initialize()
    ##############################################################################
    @usersessions = Hash.new()
  end

  ################################################################################
  def newuser(sessionid, computerid)
    ##############################################################################
    currentsessionid = sessionid.to_sym
    @usersessions[currentsessionid] = Hash[:mysessionid,currentsessionid] if @usersessions[currentsessionid].nil?
    newusersession = @usersessions[currentsessionid]
    currentcomputerid = computerid.to_sym
    newusersession[:mycomputerid] = currentcomputerid if newusersession[:mycomputerid].nil?

#    Rails.logger.debug("newusersession[:mycomputerid] = " + newusersession[:mycomputerid].inspect)

    if  newusersession[:mycomputerid] != currentcomputerid
      Rails.logger.warn("** Computer ID's do not match")
      Rails.logger.warn("** newusersession = " + newusersession.inspect)
      Rails.logger.warn("** currentcomputerid = " + currentcomputerid.inspect)
      Rails.logger.warn("** newusersession[:mycomputerid] = " + newusersession[:mycomputerid].inspect)
    end
    return newusersession
  end

  ################################################################################
  def mysession(sessionid)
    ##############################################################################
    yoursession = @usersessions[sessionid.to_sym]
    return yoursession
  end
end

