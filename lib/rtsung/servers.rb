class RTsung
  class Servers < Base
    DEFAULT_PORT = 80
    DEFAULT_TYPE = 'tcp'

    private

    def server(host, options = {})
      attrs = {
        :host => host,
        :port => options[:port] || DEFAULT_PORT,
        :type => options[:type] || DEFAULT_TYPE
      }

      xml.server(attrs)
    end
  end
end
