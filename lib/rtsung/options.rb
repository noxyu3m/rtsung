class RTsung
  class Options < Base
    private

    def option(name, options = {}, &block)
      attrs = options.merge(:name => name)

      if block_given?
        xml.option(attrs) do
          instance_eval(&block)
        end
      else
        xml.option(attrs)
      end
    end

    def user_agent(name, options = {})
      xml.user_agent(options) do
        xml.text!(name)
      end
    end
  end
end
