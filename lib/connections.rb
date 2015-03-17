################################################################################
class Connections
  ##############################################################################
  def initialize()
    @connections = Hash.new()
  end

  ################################################################################
  def add(session,computerid)
    ##############################################################################
    completedok = false
    unless session.nil? || computerid.nil?
      @connections[session.to_sym] = computerid.to_sym
      @connections[computerid.to_sym] = session.to_sym
      if @connections[session.to_sym] == computerid.to_sym && @connections[computerid.to_sym] == session.to_sym
        completedok = true
        Rails.logger.info("Connection added for: [" + session.to_s + "] [" + computerid.to_s + "]")
        Rails.logger.info("Connection Table Start")
        Rails.logger.info(@connections.inspect)
        Rails.logger.info("Connection Table End")
      else
        Rails.logger.info("*** Session or computerid did not match")
        Rails.logger.info("*** session passed in = " + session.inspect)
        Rails.logger.info("*** @connections[session.to_sym] = " + @connections[session.to_sym].inspect)
        Rails.logger.info("*** computerid passed in = " + computerid.inspect)
        Rails.logger.info("*** @connections[computerid.to_sym] = " + @connections[computerid.to_sym].inspect)
      end
    else
      Rails.logger.info("*** Nil was passed in to addconnection.")
      Rails.logger.info("*** session = " + session.inspect)
      Rails.logger.info("*** computerid = " + computerid.inspect)
    end
    return completedok
  end

  def valid(sessionid,computerid)
    valid = false
    #    Rails.logger.warn("@connections = " + @connections.inspect)
    unless @connections.nil? || sessionid.nil? || computerid.nil?
      debugger
      if @connections[sessionid.to_sym] == computerid.to_sym && @connections[computerid.to_sym] == sessionid.to_sym
        valid = true
      end
    end
    Rails.logger.error("Validating session  session= " + sessionid.inspect + "    computerid " + computerid.inspect) unless valid
    Rails.logger.error("**** Validation Failed!") unless valid
    return valid
  end


  def createnewuser(group)
    ##############################################################################
    mysession = nil
    mysessionid = getmysessionid()
    mycomputerid = genseratecomputerid()
    mysession = $gExperiment.newuser(mysessionid, mycomputerid,group)
    return mysession
  end


end
