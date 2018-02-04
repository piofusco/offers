require 'sinatra'
require 'json'

get '/offers' do
    content_type :json
    send_file "offers.json"
end