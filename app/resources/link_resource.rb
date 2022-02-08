class LinkResource
  def initialize(args)
    @rel = args.fetch(:rel) { |_| raise_missing_key_error('rel') }
    @href = args.fetch(:href) { |_| raise_missing_key_error('href') }
    @method = args.fetch(:method, 'get')
    @type = args.fetch(:type, 'application/json') 
  end

  def as_json(*)
    {
      rel: @rel,
      href: @href,
      method: @method,
      type: @type
    }
  end

  private

  def raise_missing_key_error(key)
    raise StandardError.new("You need a #{key} argument")
  end
end