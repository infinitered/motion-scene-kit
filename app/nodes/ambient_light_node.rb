class AmbientLightNode < SCNNode
  def init
    super

    self.light = SCNLight.light
    self.light.color = NSColor.colorWithDeviceWhite(0.5, alpha: 1.0)

    self
  end
end
