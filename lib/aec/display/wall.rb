module FAECade
  module Display

    class Wall

      attr_reader :display, :physical_layout

      def initialize(controller, physical_layout)
        @controller, @physical_layout = controller, physical_layout
        @controller.register(self)
      end

      def display_offset
        physical_layout.compact.first
      end

    end

  end
end
