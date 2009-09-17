require 'aec/utils/config'
require 'aec/display/controller'
require 'aec/network/controller'

module FAECade

  def self.start(config)
    Display::Controller.create(config)
  end

end
