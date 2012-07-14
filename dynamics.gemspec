
Gem::Specification.new do |s|
  s.name = "dynamics"
  s.version = "0.0.1"
  s.default_executable = "dynamics"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ng Say Joe"]
  s.date = %q{2012-07-07}
  s.description = %q{A framework for developing RubyMotion applications quickly.}
  s.email = %q{ngsayjoe@gmail.com}
  s.files = ["lib/dynamics.rb", "bin/dynamics"]
  s.homepage = %q{http://rubygems.org/gems/dynamics}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A Framework For RubyMotion}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end