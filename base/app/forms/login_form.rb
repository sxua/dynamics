
class LoginForm < Dynamics::Form
  
  def viewDidLoad
    super
    
    self.data_source = Dynamics::Form::DataSource.new({controller: self,
      sections: [{
        rows: [{
          title: "Email",
          type: :string
        }]
      }, {
        rows: [{
          title: "Login",
          type: :submit
        }]
      }]
    })
  end
  
end