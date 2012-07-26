
module Dynamics
    
  class Application
    
  private

    def initialize(layout)
      @layout = layout
    end
        
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  MainView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      if @layout == 'Navigation'
        # @@Navigation@@
        # @@End@@       
      elsif @layout == 'Tab Bar'           
        # @@Tab Bar@@
        # @@End@@                 
      else     
        @window.rootViewController = MainController.alloc.initWithNibName(nil, bundle: nil)           
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
      if name == 'Main'
        self.title = App.name 
        self.view.backgroundColor = UIColor.whiteColor                 
      else
        self.title = name
        self.view.backgroundColor = UIColor.grayColor             
      end     
    end    
        
    def nextScreen
      self.navigationController.pushViewController(@next_controller, animated: true)      
    end
  end
  
  class View < UIView
  end
    
  class Window < UIWindow
  end
end