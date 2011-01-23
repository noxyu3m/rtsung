class RTsung
  class Client
    HOST = 'localhost'
    OPTIONS = { :vm => true }

    def initialize(host = HOST, options = OPTIONS)
      @attrs = { :host => host }

      @attrs[:use_controller_vm] = options[:vm] if options[:vm]
      @attrs[:maxusers] = options[:max_users] if options[:max_users]
      @attrs[:weight] = options[:weight] if options[:weight]
      @attrs[:cpu] = options[:cpu] if options[:cpu]

      if ip = options[:ip]
        @ips = ip.is_a?(Array) ? ip : [ip]
      else
        @ips = []
      end
    end

    def to_xml(xml)
      if @ips.empty?
        xml.client @attrs
      else
        xml.client(@attrs) do
          @ips.each { |i| xml.ip({ :value => i }) }
        end
      end
    end

  end
end
