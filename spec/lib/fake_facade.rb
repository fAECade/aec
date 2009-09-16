class FakeFacade

  def initialize(address, port, frame_length)
    @address, @port, @frame_length = address, port, frame_length
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

  # constants ftw
  SLEEP_INTERVAL = 0.001

  def received_frames
    sleep SLEEP_INTERVAL
    @received_frames.map { |frame_data| frame_data[0] }
  end

  def clear_received_frames
    @received_frames.clear
  end

end
