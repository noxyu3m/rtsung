$: << '../lib'

require 'rtsung'

rtsung = RTsung.new do
  server 'google.com'

  session :search do
    request '/'
  end
end

print rtsung.to_xml
