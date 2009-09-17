module FAECade
  module Display

    class Wall

      attr_reader :display, :physical_layout

      def initialize(controller, physical_layout)
        @controller, @physical_layout = controller, physical_layout
        @controller.register(self)
      end

    end

  end
end
