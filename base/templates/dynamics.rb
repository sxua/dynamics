
module Dynamics
    
  class Application
    attr_accessor :layout
  
  private
        
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  HomeView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      if @layout == 'Navigation'
        # @@Navigation@@
        # @@End@@       
      elsif @layout == 'Tab Bar'           
        # @@Tab Bar@@
        # @@End@@     
      elsif @layout == 'Tab Nav'           
        # @@Tab Nav@@
        # @@End@@                    
      else     
        @window.rootViewController = HomeController.alloc.initWithNibName(nil, bundle: nil)           
      end  
      true
    end    
  end
  
  class Controller < UIViewController   
    attr_accessor :next_controller, :next_view
    
    def name
      self.class.name.underscore.split('_')[0].capitalize 
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
               
      if name == 'Home'
        self.view.backgroundColor = UIColor.whiteColor                             
      else
        self.view.backgroundColor = UIColor.grayColor             
      end       
    end    
        
    def nextScreen
      navigationController.pushViewController(@next_controller, animated: true)      
    end
  end
  
  class View < UIView
  end
    
  class Window < UIWindow
  end
end