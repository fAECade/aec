class FakeFacade

  def self.create

    # TODO read these from config file

    server       = 'localhost'
    port         = 4321
    frame_length = FAECade::Display::Display::BUFFER_LENGTH

    new(server, port, frame_length)

  end

  def start
    @server_thread = Thread.start do
      server = UDPSocket.open
      server.bind(@address, @port)
      @received_frames = []
      loop do
        frame = server.recvfrom(@frame_length)
        @received_frames << frame
      end
    end
  end

  def stop
    @server_thread.kill
  end

  def received_frames
    @received_frames.map { |frame_data| frame_data[0] }
  end

  def clear_received_frames
    @received_frames.clear
  end


  private

  def initialize(address, port, frame_length)
    @address, @port, @frame_length = address, port, frame_length
  end

end
