require 'spec'

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
