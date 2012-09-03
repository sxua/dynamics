
class LoginForm < Dynamics::Form
    
  def on_submit
    super 
    
    alert = UIAlertView.new
    alert.message = "Hello World!"
    alert.show      
  end
      
protected
  
  def viewDidLoad
    super
    
    login_dsl = {
      controller: self,
      sections: 
      [
        {
          rows: 
          [
            {
              title: "Email",
              type: :string
            }, 
            {
              title: "Password",
              type: :string
            }
          ]
        }, 
        {
          rows: 
          [
            {
              title: "Login To #{App.name}",
              type: :submit
            }
          ]
        }
      ]
    }
    self.data_source = Dynamics::Form::DataSource.new(login_dsl)
  end
    
end