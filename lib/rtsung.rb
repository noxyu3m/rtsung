require 'rubygems'
require 'builder'

require 'lib/rtsung/base'
require 'lib/rtsung/clients'
require 'lib/rtsung/servers'
require 'lib/rtsung/load'
require 'lib/rtsung/options'
require 'lib/rtsung/sessions'

class RTsung
  attr_reader :xml
  
  def initialize(&block)
    @xml = Builder::XmlMarkup.new(:target => STDOUT, :indent => 2)

    @xml.instruct!
    @xml.declare! :DOCTYPE, :tsung, :SYSTEM, '/usr/share/tsung/tsung-1.0.dtd', :'[]'

    @xml.tsung do
      instance_eval(&block)
    end
  end

  private

  %w[clients servers load options sessions].each do |tag|
    class_eval "def #{tag}(&block); xml.#{tag} { #{tag.capitalize}.new(xml, &block) }; end", __FILE__, __LINE__
  end
end
