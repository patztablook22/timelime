require_relative 'lib/timelime/version'

Gem::Specification.new do |spec|
  spec.name          = "timelime"
  spec.version       = Timelime::VERSION
  spec.authors       = ["patztablook22"]
  spec.email         = ["patz@tuta.io"]

  spec.summary       = %q{a ruby timeliner}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/patztablook22/timelime"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = "timelime"
  spec.require_paths = ["lib"]
end
