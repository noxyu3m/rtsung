class RTsung
  class Phase
    OPTIONS = { :interval => 1 }

    PHASE_DURATION = 1
    PHASE_UNIT = :minute

    USERS_UNIT = :second

    def initialize(name = 1, duration = nil, unit = nil, options = {})
      @attrs = {
        :phase => name,
        :duration => duration || PHASE_DURATION,
        :unit => unit || PHASE_UNIT
      }

      options = OPTIONS if options.empty?

      if options[:rate]
        @users = {
          :arrivalrate => options[:rate],
          :unit => options[:unit] || USERS_UNIT
        }
      else
        @users = {
          :interarrival => options[:interval],
          :unit => options[:unit] || USERS_UNIT
        }
      end
    end

    def to_xml(xml)
      xml.arrivalphase(@attrs) do
        xml.users @users
      end
    end

  end
end
