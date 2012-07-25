
module Dynamics
    
  class Application
    def initialize(layout)
      @layout = layout
    end
    
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      if @layout == 'Navigation'
        # @@Navigation@@
        # @@End@@
                                
        @window.rootViewController = UINavigationController.alloc.initWithRootViewController(controller)           
      elsif @layout == 'Tab Bar'           
        controller = MainController.alloc.initWithNibName(nil, bundle: nil)    
        nav_controller = UINavigationController.alloc.initWithRootViewController(controller)

        other_controller = UIViewController.alloc.initWithNibName(nil, bundle: nil)
        other_controller.title = "Other"
        other_controller.view = Sub1View.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
        other_controller.view.backgroundColor = UIColor.purpleColor
        
        tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)    
        tab_controller.viewControllers = [nav_controller, other_controller]
        
        @window.rootViewController = tab_controller                       
      else     
        @window.rootViewController = MainController.alloc.initWithNibName(nil, bundle: nil)           
      end  
      true
    end    
  end
  
  class Controller < UIViewController   
    attr_accessor :next_controller, :next_view
    
    def load
    end
    
    def push
      self.navigationController.pushViewController(@next_controller, animated: true)      
    end
       
  private
    
    def loadView
      if @next_view.nil?
        super
      else
        self.view = @next_view      
      end
    end
    
    def viewDidLoad
      super
      
      name = self.class.name.underscore.split('_')[0].capitalize 
      if name == 'Main'
        self.title = App.name        
      else
        self.title = name
      end     
      self.view.backgroundColor = UIColor.whiteColor  
      
      load
    end    
  end
  
  class View < UIView
  end
    
  class Window < UIWindow
  end
end