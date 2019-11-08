require 'sinatra'
require 'sinatra/reloader'
require 'json'

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

@@offers = JSON.parse(File.read("offers.json")).map { |offer| Offer.new(offer) }

get '/offers' do
  content_type :json
  @@offers.map { |offer| offer.to_json }.to_json
end

get '/offers/:id/offer' do
  content_type :json
  id = params['id']
  index_to_update = @@offers.find_index { |offer| offer.id == id }
  @@offers[index_to_update].to_s.to_json
end

post '/offers/:id/offer' do
  content_type :json
  id = params['id']
  index_to_update = @@offers.find_index { |offer| offer.id == id }
  @@offers[index_to_update].favorited = !@@offers[index_to_update].favorited
end
