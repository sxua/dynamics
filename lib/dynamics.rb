
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

      base_dir = File.join(File.dirname(__FILE__), '..', 'base')

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

      f = File.new(File.join(controllers_dir, 'main_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'main_controller.rb'))) 
      f.close    

      f = File.new(File.join(controllers_dir, 'sub1_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'sub1_controller.rb'))) 
      f.close

      f = File.new(File.join(controllers_dir, 'sub2_controller.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'controllers', 'sub2_controller.rb'))) 
      f.close

      # Views

      views_dir = File.join(app_dir, 'views')  
      Dir.mkdir(views_dir)

      f = File.new(File.join(views_dir, 'main_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'main_view.rb'))) 
      f.close

      f = File.new(File.join(views_dir, 'sub1_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'sub1_view.rb'))) 
      f.close

      f = File.new(File.join(views_dir, 'sub2_view.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'app', 'views', 'sub2_view.rb'))) 
      f.close

      # Lib 

      f = File.new(File.join(lib_dir, 'dynamics.rb'), 'w+')   
      f.write(render_code(File.join(base_dir, 'templates', 'dynamics.rb')) ) 
      f.close 
    end
  end
    
  def self.setup_framework(app, path)
    lib_dir = File.join(path, 'lib')
    lib_code = render_code(File.join(lib_dir, 'dynamics.rb'))
    new_code = lib_code
    lib_code.scan(/# \@\@.+\@\@.+# \@\@End\@\@/m) do |block|    
      block.scan(/# \@\@.+\@\@/) do |placeholder|
        layout = placeholder.split(' ')[1].gsub('@', '')
        case layout
           when 'Navigation' then new_code = new_code.gsub(block, navigation_code(path))
        end      
      end
    end
    f = File.open(File.join(lib_dir, 'dynamics.rb'), 'w+')   
    f.write(new_code) 
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
  
  def self.navigation_code(path)
    code = "# @@Navigation@@\n"
    
    # Controllers
    controllers = []
    for controller in Dir.glob(File.join(path, 'app', 'controllers', '*.rb'))
      filename = File.basename(controller)
      if filename != 'main_controller.rb'
        controllers << {:filename => filename, :class_name => camelize(filename.split('.')[0]), :name => filename.split('_')[0].capitalize}
      end
    end
    code += "        controller = MainController.alloc.initWithNibName(nil, bundle: nil)\n"  
    if controllers.size > 0    
      code += "        controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('#{controllers.first[:name]}', style: UIBarButtonItemStyleBordered, target:controller, action:'push')\n"          
    end
    i = 1
    prev_controller = 'controller'
    for controller in controllers         
      code += "        sub#{i}_controller = #{controller[:class_name]}.alloc.initWithNibName(nil, bundle: nil)\n"    
      code += "        #{prev_controller}.next_controller = sub#{i}_controller\n"        
      if controller != controllers.last
        code += "        sub#{i}_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('#{controllers[i][:name]}', style: UIBarButtonItemStyleBordered, target:sub#{i}_controller, action:'push')\n"              
        prev_controller = "sub#{i}_controller"     
        i += 1        
      end
    end
    code += "        # @@End@@"
  end
  
  def self.render_code(name)
      f = File.open(name)     
      content = f.read
      f.close
      content
  end
end