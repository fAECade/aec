require 'spec_helper'

describe "The facade controller" do

  before(:all) do

    server       = 'localhost'
    port         = 4321
    frame_length = FAECade::Display::BUFFER_LENGTH

    @facade = FakeFacade.new(server, port, frame_length)
    @facade.start
    puts "Started the virtual AEC facade"

    @r, @g, @b  = 0, 0, 0
    @display    = FAECade::Display.new(@r, @g, @b)
    @controller = FAECade::Network::Controller.new(@display, server, port)
  end

  after(:each) do
    @facade.clear_received_frames
  end

  after(:all) do
    @facade.stop
    puts "Stopped the virtual AEC facade"
  end

  it "should stream frames at a rate of 25 FPS to the AEC facade" do
    @controller.start(1)
    @controller.join
    @facade.received_frames.size.should == FAECade::Network::Controller::FPS
    @facade.received_frames.all? { |f| f.should == @display.frame }
  end

  it "should always send the latest display buffer content as the current frame" do
    pending do
      @controller.start(1)
      (0..FAECade::Network::Controller::FPS).each do |idx|
        sleep 0.04
        @display.set_color(1,1,1)
        @facade.received_frames[idx].should == @display.frame
        @controller.join
      end
      @facade.received_frames.size.should == FAECade::Network::Controller::FPS
    end
  end

end
