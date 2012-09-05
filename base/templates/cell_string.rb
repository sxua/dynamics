module Dynamics

  class CellString < Cell
    TEXT_FIELD_TAG = 1000

    def build_cell(cell)
      self.control = UITextField.alloc.initWithFrame(CGRectZero)
      self.control.tag = TEXT_FIELD_TAG
      self.control.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      self.control.textAlignment = UITextAlignmentRight

      cell.swizzle(:layoutSubviews) do
        def layoutSubviews
          old_layoutSubviews

          field = viewWithTag(TEXT_FIELD_TAG)
          field.sizeToFit

          field_frame = field.frame
          field_frame.origin.x = textLabel.frame.origin.x + textLabel.frame.size.width + FIELD_BUFFER
          field_frame.origin.y = ((frame.size.height - field_frame.size.height) / 2.0).round
          field_frame.size.width = frame.size.width - field_frame.origin.x - FIELD_BUFFER
          field.frame = field_frame
        end
      end

      cell.addSubview(control)
    end

    def on_select(tableViewDelegate)
      control.becomeFirstResponder
    end
  end

end