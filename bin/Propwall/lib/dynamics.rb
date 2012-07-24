
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
        controller = MainController.alloc.initWithNibName(nil, bundle: nil)
        controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Sub2', style: UIBarButtonItemStyleBordered, target:controller, action:'pushed')
        sub1_controller = Sub2Controller.alloc.initWithNibName(nil, bundle: nil)
        controller.next_controller = sub1_controller
        sub1_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Test1', style: UIBarButtonItemStyleBordered, target:sub1_controller, action:'pushed')
        sub2_controller = Test1Controller.alloc.initWithNibName(nil, bundle: nil)
        sub1_controller.next_controller = sub2_controller
        # @@End@@
                                
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
    
    def loaded
    end
    
    def pushed 
      self.navigationController.pushViewController(@next_controller, animated: true)      
    end
       
  private
   
    def viewDidLoad
      super
      
      name = self.class.name.underscore.split('_')[0].capitalize 
      if name == 'Main'
        self.title = App.name        
      else
        self.title = name
      end           
      self.view.backgroundColor = UIColor.whiteColor  
      
      loaded
    end    
  end
  
  class Window < UIWindow
  end  
end
