
module Dynamics
  
  class Cell
    attr_accessor :control, :row
    
    FIELD_BUFFER = Device.iphone? ? 20 : 64      
        
    def initialize(row)
      self.row = row
    end    
  end      
end