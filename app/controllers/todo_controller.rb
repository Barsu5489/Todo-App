class TodoController < Sinatra::Base
set :views, './app/views'

    get '/hello' do
        'First controller'
    end
    post '/todos/create' do
        data = JSON.parse(request.body.read)

        
        begin
            # approach 1 (individual columns)
        today  = Time.now
        # title = data['title']
        # description = data['description']
        # todo = Todo.create(title: title, description: description, createdAt: today)
        # todo.to_json

            # approach 2 (individual columns)
            data["ceatedAt"] = today
            todo = Todo.create(data)
            [201, todo.to_json]
        rescue => e
            [422, {

                error: e
            }.to_json]
        end
    end

    get '/view/todos' do
        @todos = Todo.all
        erb :todos
    end
    get '/todos' do
        todos = Todo.all
        [200, todos.to_json]
    end
    put '/todos/update/:id' do
        begin
        data = JSON.parse(request.body.read)
        todo_id = params[:id].to_i
        todo = Todo.find(todo_id)
        todo.update(data)
        { message: "update success" }.to_json
    rescue => e
        {
            error: e
        }.to_json
    end

    end
    delete '/todos/destroy/:id' do
        begin
            todo_id = params[:id].to_i
            todos = Todo.find(todo_id)
            todos.destroy
            {message: "success"}.to_json
        rescue => e
            {
                error: e
            }.to_json
            
        end
    end
end