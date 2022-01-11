# note this file must be named identically to the gem's name (using hyphen)
# for it to be picked up in the Gem build
#
# THIS FILE IS NOT in the specs and is for the gem builder

$LOAD_PATH.unshift __dir__

def require_all(path)
  pattern = File.join(__dir__, path, "*.rb")
  Dir.glob(pattern).sort.each do |f|
    require f
  end
end

# require_all("generators/templates")
require_all("generators/splut")
require_all("splut/controllers/concerns")
require_all("splut/models")
# primary module for UTM. note this file is included in the specs

module Splut
  require "railtie.rb" if defined?(Rails)

  class Settings

  end

  def self.configure(&block)
    @_settings =  Settings.new

    block.call(@_settings)
  end

end


