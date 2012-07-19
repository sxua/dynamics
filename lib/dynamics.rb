
class Dynamics
  
  def self.create_scaffold(name)
    if File.exists?(name)    
      puts "Error, #{name} already exists!"
    else
      Dir.mkdir(name)
    end
  end
  
end