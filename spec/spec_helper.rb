require 'spec'
require 'enumerator' # support Array#each_slice on 1.8.6

# Support running specs with 'rake spec' and 'spec'
# If running with 'spec' command, make sure you have
# something to the effect of 'export RUBYOPT=-Ispec' set
$LOAD_PATH.unshift('lib') unless $LOAD_PATH.include?('lib')

# the library
require 'aec'

# faked aec facade server
require 'lib/fake_facade'

Spec::Runner.configure do |config|

end

module SpecHelper

  def unpacked_frame(frame)
    frame.unpack(FAECade::Network::Controller::PACK_TEMPLATE)
  end

end
