require 'spec_helper'

describe FAECade::Display::Controller do

  before :each do
    @config = FAECade::Config.load_config('config.yml')
    @controller = FAECade::Display::Controller.create(@config)
  end

  describe "when created" do

    it "should be set to the configured framerate in FPS" do
      @controller.fps.should == @config['facade']['fps']
    end

    it "should initialize a display" do
      @controller.display.should be_kind_of(FAECade::Display::Display)
    end

    it "should initialize a network controller" do
      @controller.network.should be_kind_of(FAECade::Network::Controller)
      @controller.network.host.should == @config['facade']['host']
      @controller.network.port.should == @config['facade']['port']
    end

    it "should initialize all available walls" do
      @controller.walls.count.should == FAECade::Display::Display::NR_OF_WALLS
      @controller.walls.all? { |w| w.should be_kind_of(FAECade::Display::Wall) }
    end

  end

end
