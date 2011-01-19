module RTsung
  class XML
    class LoadBlock < Block
      DEFAULT_PHASE_DURATION = 1
      DEFAULT_PHASE_UNIT = 'minute'

      DEFAULT_USER_UNIT = 'second'

      private

      def arrivalphase(phase, duration = nil, unit = nil, &block)
        attrs = {
          :phase => phase,
          :duration => duration || DEFAULT_PHASE_DURATION,
          :unit => unit || DEFAULT_PHASE_UNIT
        }

        if block_given?
          xml.arrivalphase(attrs) do
            instance_eval(&block)
          end
        else
          xml.arrivalphase(attrs)
        end
      end

      def interarrival(num, unit = nil)
        attrs = {
          :interarrival => num,
          :unit => unit || DEFAULT_USER_UNIT
        }

        xml.users(attrs)
      end

      def arrivalrate(num, unit = nil)
        attrs = {
          :arrivalrate => num,
          :unit => unit || DEFAULT_USER_UNIT
        }

        xml.users(attrs)
      end
    end
  end
end
