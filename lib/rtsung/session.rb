class RTsung
  class Session
    PROBABILITY = 100
    TYPE = :ts_http

    HTTP_VERSION = '1.1'
    HTTP_METHOD = 'GET'

    def initialize(name, options = {}, &block)
      @attrs = {
        :name => name,
        :probability => options[:probability] || PROBABILITY,
        :type => options[:type] || TYPE
      }

      @requests = []

      instance_eval(&block) if block_given?
    end

    def request(url, options = {})
      @requests << {
        :url => url,
        :version => options[:version] || HTTP_VERSION,
        :method => options[:method] || HTTP_METHOD
      }
    end

    def to_xml xml
      if @requests.empty?
        xml.session @attrs
      else
        xml.session(@attrs) do
          @requests.each { |r|
            xml.request do
              xml.http(r) 
            end
          }
        end
      end
    end

  end
end
