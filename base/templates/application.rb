module Dynamics

  class Application
    attr_accessor :authentication, :layout, :window

    def initialize
      self.layout = ''
      self.authentication = false
    end

    protected

    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window =  HomeView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      @window.makeKeyAndVisible
      case @layout
      when 'Navigation'
        # @@Navigation@@
        # @@End@@
      when 'Tab Bar'
        # @@Tab Bar@@
        # @@End@@
      when 'Tab Nav'
        # @@Tab Nav@@
        # @@End@@
      else
        @window.rootViewController = HomeController.alloc.initWithNibName(nil, bundle: nil)
      end
      true
    end
  end

end