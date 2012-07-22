
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
           when 'Navigation' then new_code = new_code.gsub(block, navigation_code)
        end      
      end
    end
    f = File.open(File.join(lib_dir, 'dynamics.rb'), 'w+')   
    f.write(new_code) 
    f.close
  
    app.files.unshift(File.join(lib_dir, 'dynamics.rb')) 
  end
  
private

  def self.navigation_code
    code = "# @@Navigation@@\n"
    code += "controller = MainController.alloc.initWithNibName(nil, bundle: nil)\n"  
    code += "controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Next', style: UIBarButtonItemStyleBordered, target:controller, action:'on_next')\n"      
    code += "sub1_controller = Sub1Controller.alloc.initWithNibName(nil, bundle: nil)\n"
    code += "sub1_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Next', style: UIBarButtonItemStyleBordered, target:sub1_controller, action:'on_next')\n"              
    code += "controller.next_controller = sub1_controller\n"
    code += "sub2_controller = Sub2Controller.alloc.initWithNibName(nil, bundle: nil)\n"
    code += "sub1_controller.next_controller = sub2_controller\n"   
    code += "# @@End@@"
  end
  
  def self.render_code(name)
      f = File.open(name)     
      content = f.read
      f.close
      content
  end
end