lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'confirmation_code/version'

Gem::Specification.new do |s|
  s.name        = "confirmation_code"
  s.version     = ConfirmationCode::VERSION
  s.date        = "2016-02-03"
  s.summary     = "use platforms like lianzhong to auto input confirmation code"
  s.description = "support platforms like lianzhong"
  s.authors     = ["seaify"]
  s.email       = "dilin.life@gmail.com"
  s.files       += `git ls-files`.split($/)
  s.homepage    = "https://github.com/seaify/confirmation_code"
  s.license     = "MIT"

  s.executables << 'confirmation_code'
  s.add_dependency 'active_support', '~> 3.0.0'
  s.add_dependency 'httpclient', '~> 2.7'
  s.add_dependency 'awesome_print', '~> 1.6'
end
