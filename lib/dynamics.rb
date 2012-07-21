
module Dynamics
    
  class Application
    def initialize(layout)
      @layout = layout
    end
    
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      if @layout == 'Navigation'
        @window.rootViewController = MainController.alloc.initWithNibName(nil, bundle: nil)           
      else     
      end  
      true
    end    
  end
  
  class Controller < UIViewController   
    def viewDidLoad
      super

      self.view.backgroundColor = UIColor.whiteColor
    end    
  end
  
  class Window < UIWindow
  end  
end