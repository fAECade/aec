module FAECade
  module Display

    class Wall

      def initialize(display)
        @display = display
        @display.register(self)
      end

    end

  end
end
