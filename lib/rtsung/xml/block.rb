module RTsung
  class XML
    class Block
      attr_reader :xml

      def initialize(xml, &block)
        @xml = xml
        instance_eval(&block)
      end
    end
  end
end
