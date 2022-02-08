class TransactionResource
  include Rails.application.routes.url_helpers
  
  def initialize(transaction:, base_url:)
    @transaction = transaction
    @base_url = base_url
  end

  def as_json(*)
    { 
      payload: payload,
      links: links.map { |l| LinkResource.new(l) }
    }
  end

  private

  attr_reader :transaction, :base_url

  def payload
    {
      id: transaction.id,
      customer: CustomerResource.new(customer: transaction.customer),
      input_amount: transaction.formatted_input,
      output_amount: transaction.formatted_output
    }
  end

  def links
    [self_link]
  end

  def self_link
    {
      href: transaction_url(transaction.id, host: base_url),
      rel: 'self',
      method: 'get'
    }
  end
end
