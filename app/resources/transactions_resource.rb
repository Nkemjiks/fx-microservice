class TransactionsResource
  include Rails.application.routes.url_helpers
  
  def initialize(transactions:, base_url:)
    @transactions = transactions
    @base_url = base_url
  end

  def as_json(*)
    { 
      payload: payload,
      links: links.map { |l| LinkResource.new(l) }
    }
  end

  private

  attr_reader :transactions, :base_url

  def payload
    transactions.map { |transaction| TransactionResource.new(transaction: transaction, base_url: base_url)}
  end

  def links
    [self_link, create_link]
  end

  def self_link
    {
      href: transactions_url(host: base_url),
      rel: 'self',
      method: 'get'
    }
  end

  def create_link
    {
      href: transactions_url(host: base_url),
      rel: 'create',
      method: 'post'
    }
  end
end
