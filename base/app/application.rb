class Application < Dynamics::Application

  def initialize
    super

    # self.layout = 'Navigation'
    # self.layout = 'Tab Bar'
    self.layout = 'Tab Nav'

    # self.authentication = true
  end
end