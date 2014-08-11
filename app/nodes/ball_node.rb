class BallNode < SCNNode
  def init
    super

    sphere = SCNSphere.sphereWithRadius(5)
    sphere.segmentCount = 60
    self.geometry = sphere

    self.geometry.firstMaterial.tap do |mat|
      mat.lightingModelName = SCNLightingModelPhong
      mat.locksAmbientWithDiffuse = true
      mat.doubleSided = false
      #mat.diffuse.color = NSColor.redColor
      mat.diffuse.contents = NSImage.imageNamed("football.png")
      mat.normal.contents = NSImage.imageNamed("football_normal.png")
      mat.normal.intensity = 0.6 # Amount the normal map is applied
      mat.specular.contents = NSImage.imageNamed("football_specular.png")
      mat.shininess = 0.3
    end

    self
  end
end
