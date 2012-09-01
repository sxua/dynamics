
module Dynamics
    
  class Row
    attr_accessor :identifier, :index, :object, :section, :title, :type    

    def initialize(params = {})
      self.index = params[:index]
      self.title = params[:title]
      self.type = params[:type]  

      case params[:type]
      when :string
        self.object = CellString.new
      when :submit
        self.object = CellSubmit.new        
      end    
    end

    def identifier
      section.index.to_s + index.to_s
    end

    def make_cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: identifier)

      cell.accessoryType = UITableViewCellAccessoryNone 
      cell.editingAccessoryType = UITableViewCellAccessoryNone
      cell.textLabel.text = title

      edit_field = object.build_cell(cell)

      cell
    end
  end
end