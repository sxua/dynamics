
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
      dynamics_dir = File.join(lib_dir, 'dynamics') 
      
      Dir.mkdir(app_dir) 
      Dir.mkdir(build_dir)       
      Dir.mkdir(resources_dir)      
      Dir.mkdir(lib_dir)    
      Dir.mkdir(dynamics_dir)  
      
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
      
      base_controllers_dir = File.join(base_dir, 'app', 'controllers')      
      Dir.foreach(base_controllers_dir) do |controller|
        if controller.include?('.rb')
          f = File.new(File.join(controllers_dir, controller), 'w+')   
          f.write(render_code(File.join(base_controllers_dir, controller))) 
          f.close          
        end
      end

      # Forms

      forms_dir = File.join(app_dir, 'forms')  
      Dir.mkdir(forms_dir)
      
      base_forms_dir = File.join(base_dir, 'app', 'forms')
      Dir.foreach(base_forms_dir) do |form|
        if form.include?('.rb')
          f = File.new(File.join(forms_dir, form), 'w+')   
          f.write(render_code(File.join(base_forms_dir, form))) 
          f.close          
        end
      end
      
      # Views

      views_dir = File.join(app_dir, 'views')  
      Dir.mkdir(views_dir)
      
      base_views_dir = File.join(base_dir, 'app', 'views')
      Dir.foreach(base_views_dir) do |view|
        if view.include?('.rb')
          f = File.new(File.join(forms_dir, view), 'w+')   
          f.write(render_code(File.join(base_views_dir, view))) 
          f.close          
        end
      end
      
      # Resources
      
      base_resources_dir = File.join(base_dir, 'resources')
      Dir.foreach(base_resources_dir) do |resource|
        if resource.include?('.png')
          f = File.new(File.join(resources_dir, resource), 'w+')   
          f.write(render_code(File.join(base_resources_dir, resource))) 
          f.close        
        end
      end            
    end
  end
    
  def self.setup_framework(app, path)    
    offset = app.files.find_index("./app/application.rb")
        
    lib_dir = File.join(path, 'lib', 'dynamics')    
    templates_dir = File.join(Gem.bin_path('dynamics', 'dynamics').gsub(File.join('bin', 'dynamics'), ''), 'base', 'templates') 
    Dir.foreach(templates_dir) do |template|
      if template.include?('.rb')
        lib_code = render_code(File.join(templates_dir, template))
        if template == 'application.rb'
          template_code = lib_code
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
        end
        f = File.open(File.join(lib_dir, template), 'w+')   
        f.write(lib_code) 
        f.close
        app.files.insert(offset, File.join(lib_dir, template))
      end
    end
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