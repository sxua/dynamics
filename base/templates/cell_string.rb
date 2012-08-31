
module Dynamics

  class CellString
    def build_cell(cell)
      field = UITextField.alloc.initWithFrame(CGRectZero)
      field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      field.textAlignment = UITextAlignmentRight
      cell.addSubview(field)
      field
    end      
  end
  
end