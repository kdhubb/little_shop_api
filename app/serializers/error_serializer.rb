class ErrorSerializer
  def initialize(error)
    @error = error
  end
  
  def serialize_not_found
    {
        errors: [
          {
            status: "404",
            title: @error.message
          }
        ]
      }
  end
end