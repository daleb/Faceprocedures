class ConfigData
  attr_reader :time
  def initialize()
    @experimentdata = YAML.load_file( Rails.root.to_s + "/config/experimentconfigdata.yml")
    @time = @experimentdata[:time]
  end

  def newtime(newvalue)
    @experimentdata[:time] = newvalue
    @time = newvalue
    saveconfigdata()
  end

  def saveconfigdata()
    File.open( Rails.root.to_s + "/config/experimentconfigdata.yml", "w" ) do |out|
      YAML.dump( @experimentdata, out )
    end
  end
end
