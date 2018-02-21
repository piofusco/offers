require 'sinatra'
require 'json'

get '/offers' do
    content_type :json
    send_file "offers-test.json"
end

get "/imgs/*.*" do
  img_name, ext = params[:splat]

  send_file File.expand_path('imgs/#{img_name}', settings.public_folder)
end