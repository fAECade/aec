require 'aec/display/display'
require 'aec/display/wall'
require 'aec/display/screen'

module FAECade
  module Display

    class Controller

      def self.create

        # only one instance needed
        return @controller if @controller

        # TODO read these from config file

        server       = 'localhost'
        port         = 4321
        frame_length = FAECade::Display::Display::FRAME_LENGTH
        r, g, b      = 0, 0, 0


        display = FAECade::Display::Display.new(r, g, b)
        network = FAECade::Network::Controller.new(display, server, port)

        @controller = new(display, network)

      end

      attr_reader :display, :network


      def fps
        network.fps
      end

      def fps=(frames_per_second)
        network.fps = frames_per_second
      end


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


      def register(wall)
        # do something smart, possibly with a yet to be created WallManager
      end


      private

      def initialize(display, network)

        @display, @network, @walls = display, network, []

        @walls << Wall.new(self, Display::MAIN_BUILDING_NORTH_LAYOUT)
        @walls << Wall.new(self, Display::MAIN_BUILDING_EAST_LAYOUT)
        @walls << Wall.new(self, Display::MAIN_BUILDING_SOUTH_LAYOUT)
        @walls << Wall.new(self, Display::MAIN_BUILDING_SOUTH_STREET_LEVEL_LAYOUT)
        @walls << Wall.new(self, Display::MAIN_BUILDING_WEST_LAYOUT)
        @walls << Wall.new(self, Display::FUTURE_LAB_NORTH_LAYOUT)
        @walls << Wall.new(self, Display::FUTURE_LAB_EAST_LAYOUT)
        @walls << Wall.new(self, Display::FUTURE_LAB_SOUTH_LAYOUT)

      end

    end

  end
end