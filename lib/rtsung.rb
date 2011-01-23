require 'rubygems'
require 'builder'

require 'rtsung/client'
require 'rtsung/server'
require 'rtsung/phase'
require 'rtsung/option'
require 'rtsung/session'

class RTsung
  LOG_LEVEL = :notice
  DUMP_TRAFFIC = false

  TSUNG_DTD = '/usr/share/tsung/tsung-1.0.dtd'

  def initialize(options = {}, &block)
    @log_level = options[:log_level] || LOG_LEVEL
    @dump_traffic = options[:dump_traffic] || DUMP_TRAFFIC
    
    @clients, @servers = [], []
    @phases, @options = [], []
    @sessions = []

    instance_eval(&block) if block_given?
  end

  def client(host, options = {})
    @clients << Client.new(host, options)
  end

  def server(host, options = {})
    @servers << Server.new(host, options)
  end

  def phase(name = 1, duration = nil, unit = nil, options = {})
    if duration.is_a? Hash
      options = duration
      duration, unit = nil, nil
    end

    if unit.is_a? Hash
      options = unit
      unit = nil
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

    xml = Builder::XmlMarkup.new(:target => output, :indent => 2)

    xml.instruct!
    xml.declare! :DOCTYPE, :tsung, :SYSTEM, TSUNG_DTD, :'[]'

    xml.tsung(:loglevel => @log_level) do
      xml.clients do
        if @clients.empty?
          Client.new.to_xml(xml)
        else
          @clients.each { |client| client.to_xml(xml) }
        end
      end

      xml.servers { @servers.each { |server| server.to_xml(xml) } }

      xml.load do
        if @phases.empty?
          Phase.new.to_xml(xml)
        else
          @phases.each { |phase| phase.to_xml(xml) }
        end
      end

      xml.options { @options.each { |o| o.to_xml(xml) } }
      xml.sessions { @sessions.each { |s| s.to_xml(xml) } }
    end

    output
  end
end
