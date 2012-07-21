
module Dynamics
  
  class Controller
    
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.backgroundColor = UIColor.blueColor    
      @window.makeKeyAndVisible      
      true
    end
      
  end
  
  class View < UIView
  end  
  
  class Window < UIWindow
  end  
end