
class LoginForm < Dynamics::Form
  
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
              title: "Login",
              type: :submit
            }
          ]
        }
      ]
    }
    self.data_source = Dynamics::Form::DataSource.new(login_dsl)
  end
    
end