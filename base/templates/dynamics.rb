
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
  
  class Form < UITableViewController
    attr_accessor :data_source   

    class DataSource     
      attr_accessor :controller, :sections, :table     

      def initialize(params = {})
        self.sections = []
        self.controller = params[:controller]

        index = 0                  
        sections = params[:sections] || params["sections"]
        for section in sections
          section = create_section(section.merge({index: index}))
          index += 1
        end

        self.table = controller.respond_to?(:table_view) ? controller.table_view : controller.tableView
        self.table.delegate = self
        self.table.dataSource = self
        self.table.reloadData      
      end

      # UITableViewDataSource Methods
      def numberOfSectionsInTableView(tableView)  
        sections.count
      end    

      def tableView(tableView, numberOfRowsInSection: section)  
        @sections[section].rows.count
      end

      def tableView(tableView, cellForRowAtIndexPath: indexPath)
        row = sections[indexPath.section].rows[indexPath.row]

        cell = tableView.dequeueReusableCellWithIdentifier(row.identifier) || begin
          row.make_cell
        end
        cell
      end

    private

      def create_section(hash = {})
        section = Section.new(hash)
        section.form = self
        self.sections << section
        section
      end    
    end

    class Section 
      attr_accessor :form, :index, :rows, :title     

      def initialize(params = {})
        self.rows = [] 
        self.index = params[:index]      
        self.title = params[:title]

        index = 0
        rows = params[:rows] || params["rows"]
        for row in rows
          row = create_row(row.merge({index: index}))
          index += 1
        end
      end

    private

      def create_row(hash = {})
        row = Row.new(hash)
        row.section = self
        self.rows << row
        row
      end
    end

    class Row
      attr_accessor :identifier, :index, :object, :section, :title, :type    

      class StringCell
        def build_cell(cell)
          field = UITextField.alloc.initWithFrame(CGRectZero)
          field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
          field.textAlignment = UITextAlignmentRight
          cell.addSubview(field)
          field
        end      
      end

      def initialize(params = {})
        self.index = params[:index]
        self.title = params[:title]
        self.type = params[:type]  

        case params[:type]
        when :string
          self.object = StringCell.new
        when :submit
          self.object = StringCell.new        
        end    
      end

      def identifier
        section.index.to_s + index.to_s
      end

      def make_cell
        cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: identifier)

        cell.accessoryType = UITableViewCellAccessoryNone 
        cell.editingAccessoryType = UITableViewCellAccessoryNone
        cell.textLabel.text = title

        edit_field = object.build_cell(cell)

        cell
      end
    end

    def init
      self.initWithStyle(UITableViewStyleGrouped)
      self
    end
  end
  
  class View < UIView
  end
    
  class Window < UIWindow
  end
end