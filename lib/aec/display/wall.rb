module FAECade
  module Display

    class Wall

      attr_reader :display, :physical_layout

      def initialize(display, physical_layout)
        @display, @physical_layout = display, physical_layout
        @display.register(self)
      end

    end

  end
end
