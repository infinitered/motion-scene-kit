# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "motion-scene-kit"
  spec.version       = VERSION
  spec.authors       = ["Todd Werth"]
  spec.email         = ["todd@infinitered.com"]
  spec.description   = %q{SceneKit stuff in RubyMotion}
  spec.summary       = %q{Some things wrapped, new stuff added, some pain removed}
  spec.homepage      = "https://github.com/infinitered/motion-scene-kit"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["motion"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "geomotion"
end
