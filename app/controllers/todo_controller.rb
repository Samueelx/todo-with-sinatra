class TodoController < Sinatra::Base
    get '/hello' do
        "Our first controller!"
    end
end