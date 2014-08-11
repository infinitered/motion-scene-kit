class CameraNode < SCNNode
  def init
    super

    sphere = SCNSphere.sphereWithRadius(1)
    sphere.segmentCount = 3
    self.geometry = sphere

    camera = SCNCamera.camera
    camera.name = 'Main camera'
    camera.xFov = 40
    camera.yFov = 40
    #camera.zNear = 1
    camera.zFar = 400

    self.camera = camera
    self
  end
end
