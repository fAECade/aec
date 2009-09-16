require 'aec/display/display'
require 'aec/display/wall'
require 'aec/display/display'

module FAECade
  module Display

    class Controller

      def self.create

        # TODO read these from config file

        server       = 'localhost'
        port         = 4321
        frame_length = FAECade::Display::Display::BUFFER_LENGTH
        r, g, b      = 0, 0, 0


        display = FAECade::Display::Display.new(r, g, b)
        network = FAECade::Network::Controller.new(display, server, port)

        new(display, network)

      end

      attr_reader :display, :network


      def run(seconds = nil)
        network.start(seconds)
      end

      def kill
        network.stop
      end


      def set_color(r, g, b)
        display.set_color(r, g, b)
      end

      def set_pixel(address, r, g, b)
        display.set_pixel(address, r, g, b)
      end


      private

      def initialize(display, network)
        @display, @network = display, network
      end

    end

  end
end