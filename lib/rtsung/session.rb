class RTsung
  class Session
    PROBABILITY = 100
    TYPE = :ts_http

    HTTP_VERSION = '1.1'
    HTTP_METHOD = 'GET'

    THINK_TIME_RANDOM = true

    def initialize(name, options = {}, &block)
      @attrs = {
        :name => name,
        :probability => options[:probability] || PROBABILITY,
        :type => options[:type] || TYPE
      }

      @steps = []

      instance_eval(&block) if block_given?
    end

    def request(url, options = {})
      @steps << {
        :type => :request,
        :attrs => {
          :url => url,
          :version => options[:version] || HTTP_VERSION,
          :method => options[:method] || HTTP_METHOD
        }
      }
    end

    def think_time(value, options = {})
      if value.is_a?(Range)
        attrs = {
          :min => value.min,
          :max => value.max
        }
      else
        attrs = { :value => value }
      end
      
      attrs[:random] = options[:random] || THINK_TIME_RANDOM
      
      @steps << {
        :type => :think_time,
        :attrs => attrs
      }
    end

    def to_xml xml
      if @steps.empty?
        xml.session @attrs
      else
        xml.session(@attrs) do
          @steps.each { |s|
            if s[:type] == :request
              xml.request do
                xml.http(s[:attrs]) 
              end
            elsif s[:type] == :think_time
              xml.thinktime(s[:attrs])
            end
          }
        end
      end
    end

  end
end
