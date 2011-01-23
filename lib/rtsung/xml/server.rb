module RTsung
  class XML
    class Server
      DEFAULT_PORT = 80
      DEFAULT_TYPE = 'tcp'

      def initialize host, options = {}
        @attrs = {
          :host => host,
          :port => options[:port] || DEFAULT_PORT,
          :type => options[:type] || DEFAULT_TYPE
        }
      end

      def to_xml xml
        xml.server @attrs
      end
    end
  end
end
