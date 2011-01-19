require 'rtsung/xml/block'
require 'rtsung/xml/clients_block'
require 'rtsung/xml/servers_block'
require 'rtsung/xml/load_block'
require 'rtsung/xml/options_block'
require 'rtsung/xml/sessions_block'

module RTsung
  class XML
    attr_reader :xml
  
    # TODO: dumptraffic option
    def initialize options = {}, &block
      options[:dtd] ||= '/usr/share/tsung/tsung-1.0.dtd'
      options[:indent] ||= 2

      options[:loglevel] ||= 'notice'

      @xml = Builder::XmlMarkup.new :target => STDOUT, :indent => options[:indent]

      @xml.instruct!
      @xml.declare! :DOCTYPE, :tsung, :SYSTEM, options[:dtd], :'[]'

      @xml.tsung(:loglevel => options[:loglevel]) { instance_eval &block }
    end

    private

    %w[clients servers load options sessions].each do |name|
      class_eval "def #{name}(&block); xml.#{name} { #{name.capitalize}Block.new xml, &block }; end", __FILE__, __LINE__
    end
  end
end
