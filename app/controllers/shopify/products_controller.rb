class Shopify::ProductsController < ApplicationController
  require 'net/http'
  require 'uri'

  def index
    shopify_access_token = ENV['Shopify_Access_Token']
    shop_name = ENV['Shop_Name']

    uri = URI.parse("https://#{shop_name}.myshopify.com/admin/api/2022-10/products.json")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.instance_of? URI::HTTPS
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = params.to_json
    request['Content-Type'] = 'application/json'
    request['X-Shopify-Access-Token'] = shopify_access_token

    @response = http.request(request)
    render json: @response.body
  end
end
