class RTsung
  class Base
    attr_reader :xml

    def initialize(xml, &block)
      @xml = xml
      instance_eval(&block) if block_given?
    end
  end
end
