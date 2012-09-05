module Dynamics

  class DataSource
    attr_accessor :controller, :sections, :table

    def initialize(params = {})
      self.sections = []
      self.controller = params[:controller]

      index = 0
      sections = params[:sections] || params["sections"]
      for section in sections
        section = create_section(section.merge({index: index}))
        index += 1
      end

      self.table = controller.respond_to?(:table_view) ? controller.table_view : controller.tableView
      self.table.delegate = self
      self.table.dataSource = self
      self.table.reloadData
    end

    def find(name)
      value = nil
      for section in sections
        value = section.find(name)
        if !value.nil?
          break
        end
      end
      value
    end

    protected

    def numberOfSectionsInTableView(tableView)
      sections.count
    end

    def tableView(tableView, cellForRowAtIndexPath: indexPath)
      row = sections[indexPath.section].rows[indexPath.row]
      tableView.dequeueReusableCellWithIdentifier(row.identifier) || row.make_cell
    end

    def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
      row = row_for_index_path(indexPath)
      case editingStyle
      when UITableViewCellEditingStyleInsert
        row.object.on_insert(tableView, self)
      when UITableViewCellEditingStyleDelete
        row.object.on_delete(tableView, self)
      end
    end

    def tableView(tableView, didSelectRowAtIndexPath: indexPath)
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      row = sections[indexPath.section].rows[indexPath.row]
      row.cell.on_select(self)
    end

    def tableView(tableView, numberOfRowsInSection: section)
      @sections[section].rows.count
    end

    def tableView(tableView, titleForHeaderInSection: section)
      section = @sections[section].name
    end

    private

    def create_section(hash = {})
      section = Section.new(hash)
      section.form = self
      self.sections << section
      section
    end
  end

end