class HomeController < ApplicationController
  def index
    render json: ::HomeResource.new(base_url: request.base_url)
  end
end