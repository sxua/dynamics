
module Dynamics
  
  class Application
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      @window.rootViewController = MainController.alloc.initWithNibName(nil, bundle: nil)         
      true
    end    
  end
  
  class Controller < UIViewController  
    def viewDidLoad
        super

        self.view.backgroundColor = UIColor.blueColor   
    end    
  end
  
  class Window < UIWindow
  end  
end