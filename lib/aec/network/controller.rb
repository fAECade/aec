module FAECade
  module Network

    class Controller

      FPS = 25

      attr_reader :display, :server, :port

      def initialize(display, server, port)
        @display, @server, @port = display, server, port
      end

      def start(seconds = nil)
        start_time = Time.now
        @player = Thread.start do
          code = lambda do
            sleep 1.0 / FPS
            update(display.frame, server, port)
            count += 1
          end
          if seconds
            count = 0
            while count < seconds * FPS do
              code.call; count += 1
            end
            #(0..seconds*FPS).each { |i| code.call }
          else
            loop { code.call }
          end
        end
        self
      end

      def join
        @player.join
      end

      def stop
        @player.kill
      end

      def update(frame, server, port)
        UDPSocket.open.send(frame, 0, server, port)
      end

    end

  end
end
