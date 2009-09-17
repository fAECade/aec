require 'spec_helper'

describe "The facade controller" do

  include SpecHelper

  before(:all) do

    @facade = FakeFacade.create
    @facade.start
    puts "Started the virtual AEC facade"

    @r, @g, @b  = 0, 0, 0
    @controller = FAECade::Display::Controller.create
    @controller.set_color(@r, @g, @b)
    puts "Started the AEC facade display controller"

  end

  after(:each) do
    @facade.clear_received_frames
  end

  after(:all) do
    @facade.stop
    puts "Stopped the virtual AEC facade"
    @controller.kill
    puts "Stopped the AEC facade display controller"
  end

  it "should respect the specified framerate when streaming to the AEC facade" do

    @controller.run(1)
    @controller.network.join

    @facade.received_frames.size.should == @controller.fps
    @facade.received_frames.all? { |f| unpacked_frame(f).should == @controller.display.buffer }

  end

  it "should always send the latest display buffer content as the current frame" do

    start_frame = @controller.display.buffer.dup

    @controller.run(1)
    sleep 0.4
    @controller.set_color(2,2,2)
    sleep 0.4

    stop_frame = @controller.display.buffer.dup

    @controller.network.join

    @facade.received_frames.size.should == @controller.fps

    unpacked_frame(@facade.received_frames.first).should == start_frame
    unpacked_frame(@facade.received_frames.last ).should == stop_frame

  end

end
