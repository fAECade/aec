module FAECade

  class Display

    NR_OF_ADDRESSES = 1085
    PACKET_SIZE     =    5
    BUFFER_LENGTH   = NR_OF_ADDRESSES * PACKET_SIZE

    OFFSET_LOW      =    0 # offset of low panel address byte
    OFFSET_HIGH     =    1 # offset of high panel address byte
    OFFSET_RED      =    2 # offset of red color in package
    OFFSET_GREEN    =    3 # offset of green color in package
    OFFSET_BLUE     =    4 # offset of blue color in package

    DEFAULT_RED     =  120
    DEFAULT_GREEN   =  120
    DEFAULT_BLUE    =    0

    attr_reader :buffer

    # Initialize a new illumination frame for the AEC facade
    #
    # Created frame is guaranteed to be valid wrt to the AEC spec
    # If no color is given, all AEC windows will be set to the
    # specified default color.
    #
    # @param [Color::RGB] color Default color for all AEC windows
    #
    # @return [Frame] A definitely valid AEC illumination frame
    #
    def initialize(r, g, b)
      @buffer = []
      set_color(r, g, b)
    end

    def set_color(r, g, b)
      (0..NR_OF_ADDRESSES - 1).each do |address|
        set_pixel(address, r, g, b)
      end
      self
    end

    def set_pixel(address, r, g, b)
      buffer[ address * PACKET_SIZE + OFFSET_LOW   ] = address % 256
      buffer[ address * PACKET_SIZE + OFFSET_HIGH  ] = address / 256
      buffer[ address * PACKET_SIZE + OFFSET_RED   ] = r
      buffer[ address * PACKET_SIZE + OFFSET_GREEN ] = g
      buffer[ address * PACKET_SIZE + OFFSET_BLUE  ] = b
      self
    end

    def frame
      buffer.map { |b| b.chr }.join
    end

  end



end
