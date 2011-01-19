class RTsung
  class Clients < Base
    private

    def client(host)
      xml.client(:host => host)
    end
  end
end
