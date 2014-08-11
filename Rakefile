# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

platform = ENV.fetch('platform', 'osx')
if platform == 'ios'
  require 'motion/project/template/ios'
elsif platform == 'osx'
  require 'motion/project/template/osx'
end

require 'motion/project/template/gem/gem_tasks'
require 'bundler'
Bundler.require

require 'geomotion'
require './motion/motion-scene-kit'

Motion::Project::App.setup do |app|
  app.name = 'motion-scene-kit'
  app.identifier = "com.infinitered.motion-scene-kit"

  app.frameworks += ["SceneKit", "QuartzCore", "GLKit", "AVFoundation"]
end
