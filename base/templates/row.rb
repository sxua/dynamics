
module Dynamics
    
  class Row
    attr_accessor :cell, :identifier, :index, :name, :section, :type, :value    

    def initialize(params = {})
      self.index = params[:index]
      self.name = params[:name]
      self.type = params[:type]  

      case params[:type]
      when :string
        self.cell = CellString.new(self)
      when :submit
        self.cell = CellSubmit.new(self)        
      end    
    end

    def identifier
      section.index.to_s + index.to_s
    end

    def make_cell
      cell_control = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: identifier)
      cell_control.accessoryType = UITableViewCellAccessoryNone 
      cell_control.editingAccessoryType = UITableViewCellAccessoryNone
      cell_control.textLabel.text = name

      cell.build_cell(cell_control)
      cell_control
    end
    
    def value
      cell.control.text
    end
  end
end