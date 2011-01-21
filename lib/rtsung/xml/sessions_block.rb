module RTsung
  class XML
    class SessionsBlock < Block
      DEFAULT_PROBABILITY = 100
      DEFAULT_TYPE = 'ts_http'

      DEFAULT_THINK_RANDOM = true

      DEFAULT_HTTP_VERSION = '1.1'
      DEFAULT_HTTP_METHOD = 'GET'

      private

      def session(name, options = {}, &block)
        attrs = {
          :name => name,
          :probability => options[:probability] || DEFAULT_PROBABILITY,
          :type => options[:type] || DEFAULT_TYPE
        }
        
        if block_given?
          xml.session(attrs) do
            instance_eval(&block)
          end
        else
          xml.session(attrs)
        end
      end

      def request(url, options = {})
        attrs = {
          :url => url,
          :version => options[:version] || DEFAULT_HTTP_VERSION,
          :method => options[:method] || DEFAULT_HTTP_METHOD
        }
        
        xml.request do
          xml.http(attrs)
        end
      end

      def think(time, options = {})
        attrs = {
          :random => options[:random] || DEFAULT_THINK_RANDOM
        }

        if time.is_a? Range
          attrs.merge!({ :min => time.min, :max => time.max})

          xml.thinktime(attrs)
        else
          attrs[:value] = time

          xml.thinktime(attrs)
        end
      end
    end
  end
end
