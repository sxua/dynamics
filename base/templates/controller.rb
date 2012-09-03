
module Dynamics
    
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
    
  protected
          
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
          navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle(next_controller.name, style: UIBarButtonItemStyleBordered, target: self, action: 'next_screen')          
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
  
private
  
  def next_screen
    navigationController.pushViewController(@next_controller, animated: true)      
  end  
end