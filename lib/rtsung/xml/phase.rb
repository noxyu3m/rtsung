module RTsung
  class XML
    class Phase
      DEFAULT_PHASE_DURATION = 1
      DEFAULT_PHASE_UNIT = :minute

      DEFAULT_USERS_UNIT = :second

      def initialize name, duration = nil, unit = nil, options = {}
        @attrs = {
          :phase => name,
          :duration => duration || DEFAULT_PHASE_DURATION,
          :unit => unit || DEFAULT_PHASE_UNIT
        }

        if options[:rate]
          @users = {
            :arrivalrate => options[:rate],
            :unit => options[:unit] || DEFAULT_USERS_UNIT
          }
        else
          @users = {
            :interarrival => options[:interval],
            :unit => options[:unit] || DEFAULT_USERS_UNIT
          }
        end
      end

      def to_xml xml
        xml.arrivalphase(@attrs) { xml.users(@users) }
      end
    end
  end
end
