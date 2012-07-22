
module Dynamics
    
  class Application
    def initialize(layout)
      @layout = layout
    end
    
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      if @layout == 'Navigation'
        # @layouts/navigation@
                        
        @window.rootViewController = UINavigationController.alloc.initWithRootViewController(controller)           
      elsif @layout == 'Tab Bar'           
        controller = MainController.alloc.initWithNibName(nil, bundle: nil)    
        nav_controller = UINavigationController.alloc.initWithRootViewController(controller)

        tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
        tab_controller.viewControllers = [nav_controller]
        
        @window.rootViewController = tab_controller                       
      else     
        @window.rootViewController = MainController.alloc.initWithNibName(nil, bundle: nil)           
      end  
      true
    end    
  end
  
  class Controller < UIViewController   
    attr_accessor :next_controller
    
    def on_next 
      self.navigationController.pushViewController(@next_controller, animated: true)      
    end
       
  private
   
    def viewDidLoad
      super
      
      self.title = App.name
      self.view.backgroundColor = UIColor.whiteColor  
    end    
  end
  
  class Window < UIWindow
  end  
end