#
# KING SABRI | @KINGSABRI
#

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
  module Builder

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
    def build_web_xml(jsp_file: , servlet_name:)
      servlet_name = servlet_name || File.basename(jsp_file, ".*")

      <<~WEBXML
        <?xml version="1.0" ?>
        <web-app xmlns="http://java.sun.com/xml/ns/j2ee"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee
           http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
          version="2.4">
        <servlet>
          <servlet-name>#{servlet_name.capitalize}</servlet-name>
          <jsp-file>/#{jsp_file}</jsp-file>
        </servlet>
        </web-app>
      WEBXML
    end
  end
end


