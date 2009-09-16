require 'spec_helper'

describe "The virtual AEC facade display" do

  before :each do
    @r, @g, @b = 120, 120, 0
    @display = FAECade::Display::Display.new(@r, @g, @b)
  end

  describe "when created" do

    it "should contain the number of panels specified by the AEC spec" do
      @display.buffer.length.should == FAECade::Display::Display::BUFFER_LENGTH
    end

    it "should set all panels to the specified color" do
      pixel = 0
      @display.buffer.each_slice(5) do |packet|
        packet[ FAECade::Display::Display::OFFSET_LOW   ].should == pixel % 2**8
        packet[ FAECade::Display::Display::OFFSET_HIGH  ].should == pixel / 2**8
        packet[ FAECade::Display::Display::OFFSET_RED   ].should == @r
        packet[ FAECade::Display::Display::OFFSET_GREEN ].should == @g
        packet[ FAECade::Display::Display::OFFSET_BLUE  ].should == @b
        pixel += 1
      end
    end

  end

  it "should be able to set a single AEC panel to the specified color and leave others untouched" do
    pixel_to_set = 0
    @display.set_pixel(pixel_to_set, @r + 1, @g + 1, @b + 1)

    pixel = 0
    @display.buffer.each_slice(FAECade::Display::Display::PACKET_SIZE) do |packet|
      if pixel == pixel_to_set
        packet[ FAECade::Display::Display::OFFSET_RED   ].should == @r + 1
        packet[ FAECade::Display::Display::OFFSET_GREEN ].should == @g + 1
        packet[ FAECade::Display::Display::OFFSET_BLUE  ].should == @b + 1
      else
        packet[ FAECade::Display::Display::OFFSET_RED   ].should == @r
        packet[ FAECade::Display::Display::OFFSET_GREEN ].should == @g
        packet[ FAECade::Display::Display::OFFSET_BLUE  ].should == @b
      end
      pixel += 1
    end
    pixel.should == FAECade::Display::Display::NR_OF_ADDRESSES
  end

end
