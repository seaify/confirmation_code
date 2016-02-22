lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'confirmation_code/version'

Gem::Specification.new do |s|
  s.name        = "confirmation_code"
  s.version     = ConfirmationCode::VERSION
  s.date        = "2016-02-03"
  s.summary     = "use platforms like lianzhong to auto input confirmation code"
  s.description = "use platforms like lianzhong to auto input confirmation code"
  s.authors     = ["seaify"]
  s.email       = "dilin.life@gmail.com"
  s.files       = Dir["lib/confirmation_code.rb"]
  s.homepage    = "https://github.com/seaify/confirmation_code"
  s.license     = "MIT"

  s.executables << 'confirmation_code'
  s.add_dependency 'excon'
  s.add_dependency 'httpclient'
  s.add_dependency 'awesome_print', '~> 1.6'
end
