class TodoController < Sinatra::Base
    get '/hello' do
        "Our first controller!"
    end

    post '/todos/create' do
        data = JSON.parse(request.body.read)

        begin
            #Approach 1: Individual columns
            today = Time.now
            # title = data["title"]
            # description = data["description"]

            # todo = Todo.create(title: title, description: description, createdAt: today)
            # todo.to_json  
            
            #Approach 2: Hash of the columns
            data["createdAt"] = today
            todo = Todo.create(data)
            [201, todo.to_json]
        rescue => exception
            [422, {
                error: exception.message
            }.to_json] 
        end
        
    end

    get '/todos' do
        todos = Todo.all
        [200, todos.to_json]
    end

    put '/todos/update/:id' do
        begin
            data = JSON.parse(request.body.read)
            todo_id = params['id'].to_i
            todo = Todo.find(todo_id)
            todo.update(data)
            [201, {message: "Todo updated successfully"}.to_json]
        rescue => exception
            [422, {error: exception.message}.to_json]    
        end
    end

    delete '/todos/destroy/:id' do
        begin
            todo_id = params['id'].to_i
            todo = Todo.find(todo_id)
            todo.destroy()
            [201, {message: "todo deleted successfully"}.to_json]
        rescue => exception
            [422, {error: exception.message}.to_json]
        end
    end
end