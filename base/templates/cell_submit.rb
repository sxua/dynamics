
module Dynamics
  
  class CellSubmit
    FIELD_BUFFER = Device.iphone? ? 20 : 64
          
    def build_cell(cell)
      cell.swizzle(:layoutSubviews) do
        def layoutSubviews
          old_layoutSubviews

          self.textLabel.center = CGPointMake(frame.size.width / 2 - (FIELD_BUFFER / 2), textLabel.center.y)
          self.detailTextLabel.center = CGPointMake(frame.size.width / 2 - (FIELD_BUFFER / 2), detailTextLabel.center.y)
        end
      end      
      nil
    end
        
    def on_select(tableView, tableViewDelegate)
      tableViewDelegate.submit
    end 
  end      
end