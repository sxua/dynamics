
module Dynamics

  class Section 
    attr_accessor :form, :index, :rows, :title     

    def initialize(params = {})
      self.rows = [] 
      self.index = params[:index]      
      self.title = params[:title]

      index = 0
      rows = params[:rows] || params["rows"]
      for row in rows
        row = create_row(row.merge({index: index}))
        index += 1
      end
    end

  private

    def create_row(hash = {})
      row = Row.new(hash)
      row.section = self
      self.rows << row
      row
    end
  end

end