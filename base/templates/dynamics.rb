
module Dynamics
    
  class Application
    attr_accessor :layout, :login, :window
  
    def initialize
      self.layout = ''
      self.login = false
    end
    
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
        sub_names = self.class.name.underscore.split('_')
        @name = sub_names[0, sub_names.size - 1].collect {|x| x.capitalize }.join 
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
    
    def nextScreen
      navigationController.pushViewController(@next_controller, animated: true)      
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
        
        if App.delegate.login
          login_controller = LoginForm.alloc.init
          App.delegate.window.addSubview login_controller.view
          view.removeFromSuperview     
        end                           
      else
        self.view.backgroundColor = UIColor.grayColor             
      end       
    end    
  end
  
  class Form < UIViewController
  end
  
  class View < UIView
  end
    
  class Window < UIWindow
  end
end