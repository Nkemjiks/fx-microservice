class HomeResource
  include Rails.application.routes.url_helpers

  def initialize(base_url:)
    @base_url = base_url
  end

  def as_json(*)
    { 
      payload: payload,
      links: links.map { |l| LinkResource.new(l) }
    }
  end
  
  private

  attr_reader :base_url

  def payload
    {
      message: 'Welcome to Aza Fx transaction Microservices.'
    }
  end

  def links
    [self_link, transactions_self_link, transactions_create_link]
  end

  def self_link
    {
      href: root_url(host: base_url),
      rel: 'self',
      method: 'get'
    }
  end

  def transactions_self_link
    {
      href: transactions_url(host: base_url),
      rel: 'self-transactions',
      method: 'get'
    }
  end

  def transactions_create_link
    {
      href: transactions_url(host: base_url),
      rel: 'create-transaction',
      method: 'post'
    }
  end
end
