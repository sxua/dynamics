
module Dynamics
  
  def self.create_scaffold(name, path)
    if File.exists?(name)    
      puts "Error, #{name} already exists!"
    else  
      Dir.mkdir(name)

      # Base

      app_dir = File.join(name, 'app')    
      build_dir = File.join(name, 'build')      
      resources_dir = File.join(name, 'resources')     
      lib_dir = File.join(name, 'lib')   

      Dir.mkdir(app_dir) 
      Dir.mkdir(build_dir)       
      Dir.mkdir(resources_dir)      
      Dir.mkdir(lib_dir)    

      base_dir = File.join(path, '..', 'base')

      f = File.new(File.join(name, 'Rakefile'), 'w+')   
      code = render_code(File.join(base_dir, 'Rakefile'))
      code.gsub!("app.name = ''", "app.name = '#{name}'")
      code.gsub!("app.delegate_class = ''", "app.delegate_class = '#{name}'")    
      f.write(code) 
      f.close  

      # App

      f = File.new(File.join(app_dir, 'application.rb'), 'w+')   
      code = render_code(File.join(base_dir, 'app', 'application.rb')) 
      code.gsub!("class Application", "class #{name}")    
      f.write(code) 
      f.close

      # Controllers 

      controllers_dir = File.join(app_dir, 'controllers')    
      Dir.mkdir(controllers_dir)    

      f = File.new(File.join(controllers_dir, 'home_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'home_controller.rb'))) 
      f.close    

      f = File.new(File.join(controllers_dir, 'sub1_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'sub1_controller.rb'))) 
      f.close

      f = File.new(File.join(controllers_dir, 'sub2_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'sub2_controller.rb'))) 
      f.close

      # Forms

      views_dir = File.join(app_dir, 'forms')  
      Dir.mkdir(forms_dir)

      f = File.new(File.join(forms_dir, 'login_form.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'forms', 'login_form.rb'))) 
      f.close
      
      # Views

      views_dir = File.join(app_dir, 'views')  
      Dir.mkdir(views_dir)

      f = File.new(File.join(views_dir, 'home_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'home_view.rb'))) 
      f.close

      f = File.new(File.join(views_dir, 'sub1_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'sub1_view.rb'))) 
      f.close

      f = File.new(File.join(views_dir, 'sub2_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'sub2_view.rb'))) 
      f.close
      
      # Resources

      f = File.new(File.join(resources_dir, 'icon-57.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'icon@57.png'))) 
      f.close      
      
      f = File.new(File.join(resources_dir, 'icon-74.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'icon@74.png'))) 
      f.close
         
      f = File.new(File.join(resources_dir, 'icon-114.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'icon@114.png'))) 
      f.close
             
      f = File.new(File.join(resources_dir, 'icon-144.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'icon@144.png'))) 
      f.close
                      
      f = File.new(File.join(resources_dir, 'home.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'home.png'))) 
      f.close
      
      f = File.new(File.join(resources_dir, 'sub1.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'sub1.png'))) 
      f.close
      
      f = File.new(File.join(resources_dir, 'sub2.png'), 'w+')   
      f.write(render_code(File.join(base_dir, 'resources', 'sub2.png'))) 
      f.close                  
    end
  end
    
  def self.setup_framework(app, path)
    lib_dir = File.join(path, 'lib')    
    templates_dir = File.join(Gem.bin_path('dynamics', 'dynamics').gsub(File.join('bin', 'dynamics'), ''), 'base', 'templates')
   
    template_code = lib_code = render_code(File.join(templates_dir, 'dynamics.rb'))
    template_code.scan(/# @@.+?@@.+?# @@End@@/m) do |block|
      block.scan(/^# @@.+?@@/) do |placeholder|
        layout = placeholder.gsub('# @@', '').gsub('@', '')
        case layout
           when 'Navigation' then lib_code = lib_code.gsub(block, navigation_code(path))
           when 'Tab Bar' then lib_code = lib_code.gsub(block, tab_bar_code(path))        
           when 'Tab Nav' then lib_code = lib_code.gsub(block, tab_nav_code(path))                       
        end      
      end
    end
    f = File.open(File.join(lib_dir, 'dynamics.rb'), 'w+')   
    f.write(lib_code) 
    f.close
  
    app.files.unshift(File.join(lib_dir, 'dynamics.rb')) 
  end
  
private

  def self.camelize(str)
    ret = ''
    words = str.split('_')
    for word in words
      ret += word.capitalize
    end
    ret
  end
  
  def self.find_controllers(path)
    controllers = []
    for controller in Dir.glob(File.join(path, 'app', 'controllers', '*.rb'))
      filename = File.basename(controller)
      if filename != 'home_controller.rb'
        controllers << {:filename => filename, :name => filename.split('_')[0].capitalize}
      end
    end    
    controllers
  end
  
  def self.navigation_code(path)
    code = "# @@Navigation@@\n"
    code += "        home_controller = HomeController.alloc.initWithNibName(nil, bundle: nil)\n"  
    controllers = find_controllers(path)    
    i = 1
    prev_controller = 'home_controller'
    for controller in controllers         
      code += "        sub#{i}_controller = #{controller[:name]}Controller.alloc.initWithNibName(nil, bundle: nil)\n"     
      code += "        sub#{i}_controller.next_view = #{controller[:name]}View.alloc.initWithFrame(UIScreen.mainScreen.bounds)\n"                        
      code += "        #{prev_controller}.next_controller = sub#{i}_controller\n"        
      prev_controller = "sub#{i}_controller"     
      i += 1        
    end
    code += "        @window.rootViewController = UINavigationController.alloc.initWithRootViewController(home_controller)\n"       
    code += "        # @@End@@" 
  end
  
  def self.render_code(name)
      f = File.open(name)     
      content = f.read
      f.close
      content
  end
  
  def self.tab_bar_code(path)
    code = "# @@Tab Bar@@\n"
    controllers_list = 'home_controller'    
    code += "        home_controller = HomeController.alloc.initWithNibName(nil, bundle: nil)\n"  
    i = 1       
    controllers = find_controllers(path)    
    for controller in controllers         
      controllers_list += ", sub#{i}_controller"         
      code += "        sub#{i}_controller = #{controller[:name]}Controller.alloc.initWithNibName(nil, bundle: nil)\n"
      i += 1        
    end        
    code += "        tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)\n"    
    code += "        tab_controller.viewControllers = [#{controllers_list}]\n"
    code += "        @window.rootViewController = tab_controller\n"      
    code += "        # @@End@@"  
  end  
  
  def self.tab_nav_code(path)
    code = "# @@Tab Nav@@\n"
    controllers_list = 'home_nav_controller'    
    code += "        home_controller = HomeController.alloc.initWithNibName(nil, bundle: nil)\n"  
    code += "        home_nav_controller = UINavigationController.alloc.initWithRootViewController(home_controller)\n"    
    i = 1       
    controllers = find_controllers(path)    
    for controller in controllers         
      controllers_list += ", sub#{i}_nav_controller"         
      code += "        sub#{i}_controller = #{controller[:name]}Controller.alloc.initWithNibName(nil, bundle: nil)\n"
      code += "        sub#{i}_nav_controller = UINavigationController.alloc.initWithRootViewController(sub#{i}_controller)\n"        
      i += 1        
    end        
    code += "        tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)\n"    
    code += "        tab_controller.viewControllers = [#{controllers_list}]\n"
    code += "        @window.rootViewController = tab_controller\n"      
    code += "        # @@End@@"  
  end  
end