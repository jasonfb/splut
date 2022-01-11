module Splut
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'generators/splut/install_generator.rb'
    end
  end
end