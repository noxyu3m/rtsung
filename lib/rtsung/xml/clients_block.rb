module RTsung
  class XML
    class ClientsBlock < Block
      private

      # TODO: job scheduler
      def host(name, options = {}, &block)
        attrs = {
          :host => name
        }

        [:use_controller_vm, :weight, :maxusers, :cpu].each do |o|
          attrs[o] = options[o] if options[o]
        end

        if block_given?
          xml.client(attrs) do
            instance_eval(&block)
          end
        else
          xml.client(attrs)
        end
      end

      def ip(address)
        xml.ip(:value => address)
      end
    end
  end
end
