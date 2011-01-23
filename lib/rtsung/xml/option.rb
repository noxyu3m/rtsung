module RTsung
  class XML
    class Option
      DEFAULT_TYPE = :ts_http

      DEFAULT_USER_AGENT_PROBABILITY = 100

      def initialize name, options = {}, &block
        @attrs = {
          :name => name,
          :type => options[:type] || DEFAULT_TYPE
        }

        @user_agents = []

        instance_eval &block if block_given?
      end

      def user_agent name, options = {}
        @user_agents << {
          :name => name,
          :probability => options[:probability] || DEFAULT_USER_AGENT_PROBABILITY
        }
      end

      def to_xml xml
        if @user_agents.empty?
          xml.option @attrs
        else
          xml.option(@attrs) {
            @user_agents.each { |u|
              xml.user_agent({ :probability => u[:probability] }) { xml.text! u[:name] }
            }
          }
        end
      end
    end
  end
end
