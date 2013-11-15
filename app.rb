require "sinatra"
require "sinatra/activerecord"
require './app/models/todo'
set :database, 'sqlite://db/development.sqlite'
set :views, './app/views'




get '/' do 
	redirect '/todos'
end

#createsource 'https://rubygems.org'
get '/todos/new' do 
	erb '/todos/new'.to_sym
end

post '/todos' do 
	Todo.create(params)
	 redirect '/todos'
end

#Read
get '/todos' do 
	 @todos = Todo.all 
	 erb '/todos/index'.to_sym
end
get '/todos/:id' do # /todos/1
  @todo = Todo.find params[:id]
  erb 'todos/show'.to_sym
end

#update

get '/todos/:id/edit' do # /todo/1/edit
  @todo = Todo.find(params[:id])
  erb 'todos/edit'.to_sym
end

post '/todos/:id/edit' do
  todo = Todo.find(params[:id])
  todo.update_attributes(title: params[:title], content: params[:content])
  redirect "/todos "
end

#destroy

post '/todos/:id/delete' do 
	todo = Todo.find(params[:id])
	todo.destroy
	redirect '/todos'
end