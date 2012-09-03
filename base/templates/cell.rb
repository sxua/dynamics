
module Dynamics
  
  class Cell
    attr_accessor :control, :row
    
    def initialize(row)
      self.row = row
    end
        
    FIELD_BUFFER = Device.iphone? ? 20 : 64          
  end      
end