class AppDelegate
  attr_accessor :mainWindow

  def applicationDidFinishLaunching(notification)
    buildMenu

    @mainWindow = MainWindow.alloc.init
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.setCollectionBehavior(NSWindowCollectionBehaviorFullScreenPrimary)
    @mainWindow.orderFrontRegardless
    @mainWindow.setAcceptsMouseMovedEvents true

    @mainWindow.setFrame([[0,0],[800,800]], display: true, animate: true)

    @mainWindow.delegate = self

    @view = MainView.alloc.initWithFrame(@mainWindow.frame)
    @mainWindow.contentView.addSubview @view
    @mainWindow.makeFirstResponder @view
  end

  def windowDidResize(notification)
    @view.frame = @mainWindow.contentView.bounds
  end
end
