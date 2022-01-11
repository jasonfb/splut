

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version.rb"

Gem::Specification.new do |s|
  s.name        = 'splut'
  s.version     = Splut::VERSION
  s.license     = 'MIT'
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "A/B split testing Rails engine"
  s.description = ""
  s.authors     = ["Jason Fleetwood-Boldt"]
  s.email       = 'code@jasonfb.net'

  all_files       = `git ls-files -z`.split("\x0")

  s.files         = all_files.reject{|x| !x.start_with?('lib')}

  s.require_paths = ["lib"]

  s.homepage    = 'https://heliosdev.shop/splut/'

  s.metadata    = { "source_code_uri" => "https://github.com/jasonfb/splut",
                    "homepage_uri" => 'https://github.com/jasonfb/splut'}


  s.add_dependency('rails', '> 5.1')
  s.add_runtime_dependency('counter_culture')

  s.add_development_dependency('simplecov')
  s.add_development_dependency('simplecov-rcov')
  # s.add_development_dependency('appraisal', '> 2.2')
end