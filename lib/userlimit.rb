class UserLimit
  attr_reader :limit
  def initialize()
    @experimentdata = YAML.load_file( Rails.root.to_s + "/config/userlimitdata.yml")
    @time = @experimentdata[:limit]
  end

  def newlimit(newvalue)
    @experimentdata[:limit] = newvalue
    @limit = newvalue
    saveconfigdata()
  end

  def saveconfigdata()
    File.open( Rails.root.to_s + "/config/userlimitdata.yml", "w" ) do |out|
      YAML.dump( @experimentdata, out )
    end
  end

end