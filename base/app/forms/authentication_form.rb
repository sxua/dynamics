class AuthenticationForm < Dynamics::Form

  def on_submit
    super

    # email = data_source.find('Email')
    # password = data_source.find('Password')
  end

protected

  def viewDidLoad
    super

    auth_dsl = {
      controller: self,
      sections:
      [
        {
          rows:
          [
            {
              name: "Email",
              type: :string
            },
            {
              name: "Password",
              type: :string
            }
          ]
        },
        {
          rows:
          [
            {
              name: "Login To #{App.name}",
              type: :submit
            }
          ]
        }
      ]
    }
    self.data_source = Dynamics::DataSource.new(auth_dsl)
  end

end