module RTsung
  class XML
    class Session
      DEFAULT_PROBABILITY = 100
      DEFAULT_TYPE = :ts_http

      DEFAULT_HTTP_VERSION = '1.1'
      DEFAULT_HTTP_METHOD = 'GET'

      def initialize name, options = {}, &block
        @attrs = {
          :name => name,
          :probability => options[:probability] || DEFAULT_PROBABILITY,
          :type => options[:type] || DEFAULT_TYPE
        }

        @requests = []

        instance_eval &block if block_given?
      end

      def request url, options = {}
        @requests << {
          :url => url,
          :version => options[:version] || DEFAULT_HTTP_VERSION,
          :method => options[:method] || DEFAULT_HTTP_METHOD
        }
      end

      def to_xml xml
        if @requests.empty?
          xml.session @attrs
        else
          xml.session(@attrs) {
            @requests.each { |r|
              xml.request { xml.http(r) }
            }
          }
        end
      end
    end
  end
end
