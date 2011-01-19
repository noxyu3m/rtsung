class RTsung
  class Sessions < Base
    DEFAULT_PROBABILITY = 100
    DEFAULT_TYPE = 'ts_http'

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
  end
end
