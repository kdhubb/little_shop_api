class ErrorSerializer
  def initialize(error)
    @error = error
  end
  
  def not_found
    {
        errors: [
          {
            status: "404",
            title: @error.message
          }
        ]
      }
  end

  def no_param_error
    {
      errors: [
        {
          status: "400",
          title: @error = "No search paramater given"
        }
      ]
    }
  end
end