require 'spec_helper'

describe "The facade controller" do

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
  end

  it "should stream frames at a rate of 25 FPS to the AEC facade" do
    @controller.run(1)
    @controller.network.join
    @facade.received_frames.size.should == FAECade::Network::Controller::FPS
    @facade.received_frames.all? { |f| f.should == @controller.display.frame }
  end

  it "should always send the latest display buffer content as the current frame" do
    pending do
      @controller.run(1)
      (0..FAECade::Network::Controller::FPS).each do |idx|
        sleep 0.04
        @controller.set_color(1,1,1)
        @facade.received_frames[idx].should == @controller.display.frame
        @controller.network.join
      end
      @facade.received_frames.size.should == FAECade::Network::Controller::FPS
    end
  end

end
