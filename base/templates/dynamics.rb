
module Dynamics
    
  class Application
    attr_accessor :layout
  
  private
        
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  HomeView.alloc.initWithFrame(UIScreen.mainScreen.bounds)  
      @window.makeKeyAndVisible   
      case @layout
      when 'Navigation'
        # @@Navigation@@
        # @@End@@       
      when 'Tab Bar'           
        # @@Tab Bar@@
        # @@End@@     
      when 'Tab Nav'           
        # @@Tab Nav@@
        # @@End@@                    
      else     
        @window.rootViewController = HomeController.alloc.initWithNibName(nil, bundle: nil)           
      end  
      true
    end    
  end
  
  class Controller < UIViewController   
    attr_accessor :name, :next_controller, :next_view
       
    def initWithNibName(name, bundle: bundle)
        super
        
        @@index = 0
        @name = self.class.name.underscore.split('_')[0].capitalize 
        case App.delegate.layout
        when 'Navigation'
          if @name == 'Home'
            self.navigationItem.title = App.name   
          end   
        when 'Tab Bar'   
          self.tabBarItem = UITabBarItem.alloc.initWithTitle(@name, image: UIImage.imageNamed(@name.downcase + '.png'), tag: @@index)                                               
        when 'Tab Nav'      
          if @name == 'Home'
            self.navigationItem.title = App.name         
          else
            self.navigationItem.title = @name                 
          end                                            
          self.tabBarItem = UITabBarItem.alloc.initWithTitle(@name, image: UIImage.imageNamed(@name.downcase + '.png'), tag: @@index)                  
        end        
        @@index += 1
        self
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
               
      case App.delegate.layout
      when 'Navigation'
        if !next_controller.nil?
          navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle(next_controller.name, style: UIBarButtonItemStyleBordered, target: self, action: 'nextScreen')          
        end
      end
                  
      case @name
      when 'Home'                                      
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