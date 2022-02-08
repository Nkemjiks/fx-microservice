class CustomerResource
  include Rails.application.routes.url_helpers
  
  def initialize(customer:)
    @customer = customer
  end

  def as_json(*)
    { 
      payload: payload,
      links: []
    }
  end

  private

  attr_reader :customer

  def payload
    {
      id: customer.id,
      name: customer.name
    }
  end
end
