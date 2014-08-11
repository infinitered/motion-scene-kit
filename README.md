# motion-scene-kit

### SceneKit stuff in RubyMotion

Some things wrapped, new stuff added, some pain removed

**This is very preliminary, I'm using it in a real app, but it's very rough at this point. Also, I'm using this in OS X, I haven't tried it in iOS yet.**

## Installation

Add this line to your application's Gemfile:

```
gem 'motion-scene-kit', :git => 'https://github.com/infinitered/motion-scene-kit'
# gem 'motion-scene-kit'
```

And then execute:

```
$ bundle
```

Put this in your RakeFile file:

```ruby
app.frameworks += ["SceneKit", "QuartzCore", "GLKit", "AVFoundation"]
```

## Requires

* Geomotion. You can use Geomotion's nice CATransform3D stuff

## Usage

TODO: 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
