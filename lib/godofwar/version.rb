module GodOfWar
  VERSION = "0.1.0"

  def latest_version
    begin
      current_version = GodOfWar::VERSION
      rubygem_api     = JSON.parse open("https://rubygems.org/api/v1/versions/godofwar.json").read
      remote_version  = rubygem_api.first["number"]
      latest          = remote_version.eql?(current_version)? true : false

      latest ? current_version : remote_version
    rescue Exception => e
      puts "[!] ".yellow  + " Couldn't check the latest version, please check internet connectivity."
      exit!
    end
  end
end
