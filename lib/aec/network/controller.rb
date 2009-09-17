module FAECade
  module Network

    class Controller

      DEFAULT_FPS = 25

      # 'S' will give an unsigned short that is 2 bytes
      # 'CCC'  will give 3 unsigned chars
      # I don't know why rgb is char but the AEC spec says so
      # (if I interpret it right)
      PACK_TEMPLATE = 'SCCC' * FAECade::Display::Display::NR_OF_ADDRESSES


      attr_writer :fps
      attr_reader :display, :server, :port


      def initialize(display, server, port)
        @display, @server, @port = display, server, port
      end

      def start(seconds = nil)
        @controller = Thread.start do
          if seconds
            (seconds * fps).times { update }
          else
            loop { update }
          end
        end
      end

      def update
        #puts "sending: #{display.buffer.inspect}"
        frame = display.buffer.pack(PACK_TEMPLATE)
        send(frame, server, port)
        sleep 1.0 / fps
      end

      def join
        @controller.join
      end

      def stop
        @controller.kill
      end


      def fps
        @fps || DEFAULT_FPS
      end


      private

      def send(frame, server, port)
        UDPSocket.open.send(frame, 0, server, port)
      end

    end

  end
end
