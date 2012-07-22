controller = MainController.alloc.initWithNibName(nil, bundle: nil)   
controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Next", style: UIBarButtonItemStyleBordered, target:controller, action:'on_next')      
sub1_controller = Sub1Controller.alloc.initWithNibName(nil, bundle: nil)
sub1_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Next", style: UIBarButtonItemStyleBordered, target:sub1_controller, action:'on_next')              
controller.next_controller = sub1_controller
sub2_controller = Sub2Controller.alloc.initWithNibName(nil, bundle: nil)
sub1_controller.next_controller = sub2_controller