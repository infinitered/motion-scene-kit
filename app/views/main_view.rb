class MainView < SCNView
  def initWithFrame(frame)
    super

    self.delegate = self

    #self.jitteringEnabled = true
    self.autoenablesDefaultLighting = true
    self.allowsCameraControl = true
    self.backgroundColor = NSColor.colorWithRed((105/255.0), green: (188/255.0), blue: (229/255.0), alpha: 1.0)

    @current_scene = MainScene.scene
    self.scene = @current_scene
    self.pointOfView = @current_scene.camera_node

    self
  end

  def viewDidMoveToWindow
    super
    self.addTrackingRect(self.frame, owner: self, userData: nil, assumeInside: false)
  end

  def keyDown(event)
    process_key(event.characters)
  end

  def mouseMoved(event)
    dx = event.deltaX
    dy = event.deltaY
  end

  def process_key(character)
    case character
    when 's'
      self.showsStatistics = !self.showsStatistics
    when ""  # Up arrow
    when ""  # Right arrow
    when ""  # Down arrow
    when ""  # Left arrow
    end
  end
end

