require 'sinatra'
require 'sinatra/reloader'
require 'json'

@@offers = JSON.parse(File.read("offers.json")).map { |offer| Offer.new(offer) }

class Offer
  attr_reader :id, :url, :name, :description, :terms, :current_value, :favorited
  attr_writer :favorited

  def initialize(data)
    @id   = data['id']
    @url   = data['url']
    @name  = data['name']
    @description = data['description']
    @terms = data['terms']
    @current_value = data['current_value']
    @favorited = false
  end

  def to_json
    {
      "id" => id,
      "url" => url,
      "name" => name,
      "description" => description,
      "terms" => terms,
      "current_value" => current_value,
      "favorited" => favorited
    }
  end
end

get '/offers' do
  content_type :json
  @@offers.map { |offer| offer.to_json }.to_json
end

post '/offers/:id/offer' do
  id = params['id']
  offer_to_update = @@offers.first { |offer| offer.id == id }
  offer_to_update.favorited = !offer_to_update.favorited
end
