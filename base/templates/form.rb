
module Dynamics
    
  class Form < UITableViewController
    attr_accessor :data_source   

    def init
      self.initWithStyle(UITableViewStyleGrouped)
      self
    end
  end

end