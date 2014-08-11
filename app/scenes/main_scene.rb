class MainScene < SCNScene
  def init
    super

    @floor_node = SCNNode.node
    @floor_node.geometry = SCNFloor.floor
    rootNode.addChildNode @floor_node

    @ball_node = BallNode.node
    rootNode.addChildNode @ball_node
    @ball_node.position = [0.0, 5.0, 0.0]

    @stone_cube_node = StoneCubeNode.node
    rootNode.addChildNode @stone_cube_node
    @stone_cube_node.position = [-15.0, 15.0, -50.0]
    @stone_cube_node.rotation = [0.0, 1.0, 0.0, SCNUtils.degrees_to_radians(45)]

    @camera_node = CameraNode.node
    rootNode.addChildNode @camera_node
    @camera_node.position = [0.0, 20.0, 50.0]
    @camera_node.constraints = [SCNLookAtConstraint.lookAtConstraintWithTarget(@ball_node)]

    self
  end

  def camera_node
    @camera_node
  end

  def camera
    @camera_node.camera
  end
end
