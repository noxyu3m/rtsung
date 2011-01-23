module RTsung
  class XML
    class Client
      DEFAULT_USE_CONTROLLER_VM = true

      def initialize host, options = {}, &block
        @attrs = {
          :host => host,
          :use_controller_vm => options[:use_controller_vm] || DEFAULT_USE_CONTROLLER_VM
        }

        [:weight, :maxusers, :cpu].each { |o| @attrs[o] = options[o] if options[o] }

        @ips = []

        instance_eval &block if block_given?
      end

      def ip value
        @ips << value
      end

      def to_xml xml
        if @ips.empty?
          xml.client @attrs
        else
          xml.client(@attrs) {
            @ips.each { |i| xml.ip({ :value => i }) }
          }
        end
      end
    end
  end
end
