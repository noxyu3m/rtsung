module RTsung
  class XML
    class LoadBlock < Block
      DEFAULT_DURATION = 1
      DEFAULT_UNIT = 'minute'

      private

      def phase(name, type, value, unit, options = {})
        attrs = {
          :phase => name,
          :duration => options[:duration] || DEFAULT_DURATION,
          :unit => options[:unit] || DEFAULT_UNIT
        }

        xml.arrivalphase(attrs) do
          attrs = {
            :unit => unit
          }
          
          if type == :rate
            attrs[:arrivalrate] = value
          elsif type == :interval
            attrs[:interarrival] = value
          else
            raise
          end

          xml.users(attrs)
        end
      end
    end
  end
end
