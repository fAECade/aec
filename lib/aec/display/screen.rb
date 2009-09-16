module FAECade
  module Display

    class Screen

      def initialize(wall)
        @wall = wall
        @wall.register(self)
      end

    end

  end
end
