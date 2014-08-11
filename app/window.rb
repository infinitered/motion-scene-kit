class MainWindow < NSWindow
  def init
    self.initWithContentRect([[200, 200], [800, 800]],
                             styleMask: NSTitledWindowMask|NSResizableWindowMask,
                             backing: NSBackingStoreBuffered,
                             defer: false)
  end

  def canBecomeKeyWindow
    true
  end

  def canBecomeMainWindow
    true
  end
end
