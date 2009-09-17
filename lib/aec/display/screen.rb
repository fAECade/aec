module FAECade
  module Display

    class Screen

      def initialize(wall, root_x, root_y, area)
        @wall,@root_x, @root_y = wall, root_x, root_y
        @area = area
        @wall.register(self)
      end

      def [](x,y)

      end

      private

      #       3,4
      #     2,3,4,5
      #   1,2,3,4,5,6
      # 0,1,2,3,4,7,8,9
      #   1,2,3,4,5,6
      #     2,3,4,5
      #       3,4
      def init_virtual_area
        width = @dimensions.map { |line| line.first }.max
        @virtual_area = [][]
        @dimensions.each do |line|
          (O..width).each do |col|
            @virtual_area[line][col] = (col == line[col]) ? col : nil
          end
        end
      end

    end

  end
end
