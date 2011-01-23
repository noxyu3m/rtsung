class RTsung
  class Server
    PORT = 80
    TYPE = :tcp

    def initialize(host, options = {})
      @attrs = {
        :host => host,
        :port => options[:port] || PORT,
        :type => options[:type] || TYPE
      }
    end

    def to_xml(xml)
      xml.server @attrs
    end

  end
end
