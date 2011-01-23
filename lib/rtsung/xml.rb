require 'rtsung/xml/client'
require 'rtsung/xml/server'
require 'rtsung/xml/phase'
require 'rtsung/xml/option'
require 'rtsung/xml/session'

module RTsung
  class XML
    DEFAULT_XML_INDENT = 2
    DEFAULT_LOG_LEVEL = :notice

    TSUNG_DTD = '/usr/share/tsung/tsung-1.0.dtd'

    def initialize options = {}, &block
      @log_level = options[:log_level] || DEFAULT_LOG_LEVEL
      @xml_indent = options[:xml_indent] || DEFAULT_XML_INDENT
      
      @clients = []
      @servers = []
      @phases = []
      @options = []
      @sessions = []

      instance_eval &block if block_given?
    end

    def client host, options = {}, &block
      @clients << Client.new(host, options, &block)
    end

    def server host, options = {}
      @servers << Server.new(host, options)
    end

    def phase name, duration = nil, unit = nil, options = {}
      if duration.is_a? Hash
        options = duration
        duration, unit = nil, nil
      end

      @phases << Phase.new(name, duration, unit, options)
    end

    def option name, options = {}, &block
      @options << Option.new(name, options, &block)
    end

    def session name, options = {}, &block
      @sessions << Session.new(name, options, &block)
    end

    def to_xml
      output = ''

      xml = Builder::XmlMarkup.new :target => output, :indent => @xml_indent

      xml.instruct!
      xml.declare! :DOCTYPE, :tsung, :SYSTEM, TSUNG_DTD, :'[]'

      xml.tsung(:loglevel => @log_level) do
        xml.clients { @clients.each { |c| c.to_xml(xml) } }
        xml.servers { @servers.each { |s| s.to_xml(xml) } }

        xml.load { @phases.each { |p| p.to_xml(xml) } }
        xml.options { @options.each { |o| o.to_xml(xml) } }

        xml.sessions { @sessions.each { |s| s.to_xml(xml) } }
      end

      output
    end
  end
end
