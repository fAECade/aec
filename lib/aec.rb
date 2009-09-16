require 'aec/display/controller'
require 'aec/network/controller'

module FAECade

  def self.start
    controller = Display::Controller.create
  end

end