
module Dynamics

  class CellString < Cell
    def build_cell(cell)
      self.control = UITextField.alloc.initWithFrame(CGRectZero)
      self.control.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      self.control.textAlignment = UITextAlignmentRight
      cell.addSubview(control)
    end
    
    def on_select(tableViewDelegate)
      control.becomeFirstResponder
    end          
  end
  
end