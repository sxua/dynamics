
module Dynamics
    
  class Form < UITableViewController
    attr_accessor :data_source   

    def init
      self.initWithStyle(UITableViewStyleGrouped)
      self
    end
        
    def on_submit
    end
  end

end