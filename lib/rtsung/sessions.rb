class RTsung
  class Sessions < Base
    DEFAULT_PROBABILITY = 100
    DEFAULT_TYPE = 'ts_http'

    DEFAULT_THINK_RANDOM = true

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
