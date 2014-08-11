class StoneCubeNode < SCNNode
  def init
    super

    self.geometry = SCNBox.boxWithWidth(30, height: 30, length: 30, chamferRadius: 0.5)

    self.geometry.firstMaterial.tap do |mat|
      mat.lightingModelName = SCNLightingModelPhong
      mat.locksAmbientWithDiffuse = true
      mat.doubleSided = false
      mat.diffuse.contents = NSImage.imageNamed("stone.jpg")
      mat.normal.contents = NSImage.imageNamed("stone_normal.jpg")
      mat.normal.intensity = 0.5 # Amount the normal map is applied
    end

    self
  end
end
