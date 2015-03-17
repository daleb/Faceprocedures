class User
  attr_reader :usersonline, :usercomputerid, :userstatus, :userscreen, :userdata
  def initialize()
    @usersonline = Array.new(24)
    @usercomputerid = Array.new(24)
    @userstatus = Array.new(24)
    @userscreen = Array.new(24)
    @userdata = Array.new()
  end


  def cleanuserdata()
    @can_start = false
    @usersonline.fill(false)
    @usercomputerid.fill("")
    @userstatus.fill("Not Connected")
    @userscreen.fill(0)
    @userdata.fill(nil)
    @allow_connections = false
    @usercount = 0
    #    @userids = UserIds.new()
    #    @userconnections = Connections.new()
    #    @sessions =  UserSession.new()
    #    for i in 1..40 do
    #      @userdata[i] = UserData.new(i)
    #    end
    #    initinteractions()
  end

  
end
