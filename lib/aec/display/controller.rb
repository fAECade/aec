require 'aec/utils/config'
require 'aec/display/display'
require 'aec/display/wall'
require 'aec/display/screen'

module FAECade
  module Display

    class Controller

      def self.create(config)
        @controller ||= new(config)
      end

      attr_reader :display, :walls, :network


      def fps
        network.fps
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

      def initialize(config)

        c = config['facade']
        @display = FAECade::Display::Display.new(c['r'], c['g'], c['b'])
        @network = FAECade::Network::Controller.new(c['host'], c['port'], @display, c['fps'])

        @walls   = []

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
