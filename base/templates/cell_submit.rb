module Dynamics

  class CellSubmit < Cell
    def build_cell(cell)
      cell.swizzle(:layoutSubviews) do
        def layoutSubviews
          old_layoutSubviews

          self.textLabel.center = CGPointMake(frame.size.width / 2 - (FIELD_BUFFER / 2), textLabel.center.y)
          self.detailTextLabel.center = CGPointMake(frame.size.width / 2 - (FIELD_BUFFER / 2), detailTextLabel.center.y)
        end
      end
    end

    def on_select(tableViewDelegate)
      tableViewDelegate.controller.on_submit
    end
  end

end