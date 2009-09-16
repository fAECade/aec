module FAECade
  module Network

    class Controller

      FPS = 25

      attr_reader :display, :server, :port

      def initialize(display, server, port)
        @display, @server, @port = display, server, port
      end

      def start(seconds = nil)
        @controller = Thread.start do
          if seconds
            (seconds * FPS).times { update }
          else
            loop { update }
          end
        end
      end

      def update
        send(display.frame, server, port)
        sleep 1.0 / FPS
      end

      def join
        @controller.join
      end

      def stop
        @controller.kill
      end

      private

      def send(frame, server, port)
        UDPSocket.open.send(frame, 0, server, port)
      end

    end

  end
end
