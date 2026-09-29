require 'sinatra'
require 'json'
require_relative 'my_user_model'


set :bind, '0.0.0.0'
set :port, 8080


configure do
    enable :sessions
    set :session_secret, "your_secret_key_here_change_in_production123456789009876543211234567890"
end

get '/' do 
    @users = User.all
    erb :index
end

get '/users' do
    #the following line is in conflict with the test for delete '/users'. comment it out
    #together with a line pointed out in delete '/users' to pass this test, but then
    #the get '/users' test fails
    content_type :json
    users = User.all     
    result = users.map do |user|
        {
            "id" => user.id,
            "firstname" => user.firstname,
            "lastname" => user.lastname,
            "age" => user.age,
            "email" => user.email
        }
    end
    result.to_json
end

post '/users' do
    if params[:firstname].nil? || params[:lastname].nil? || params[:age].nil? || params[:password].nil? || params[:email].nil?
        { error: "Missing some parameters" }.to_json
    end

    if !User.find_by_email(params[:email]) #checks that user with this email doesn't exist
        user = User.create({
            firstname: params[:firstname],
            lastname: params[:lastname],
            age: params[:age],
            password: params[:password],
            email: params[:email]
          })
        result = {
            "id" => user.id,
            "firstname" => user.firstname,
            "lastname" => user.lastname,
            "age" => user.age,
            "email" => user.email
        }
        result.to_json
    else
        {error: "User with such email already exists"}.to_json
    end
end 

post '/sign_in' do
    content_type :json

    if params[:email].nil? || params[:password].nil?
        { error: "Missing some parameters" }.to_json
    end

    user = User.find_by_email(params[:email])
    if (user && user.password == params[:password]) 
        session[:user_id] = user.id
        result = {
            "id" => user.id,
            "firstname" => user.firstname,
            "lastname" => user.lastname,
            "age" => user.age,
            "email" => user.email
        }
        result.to_json
    else
        status 401
        {error: "Invalid credentials"}.to_json
    end
end

put '/users' do
    user_id = session[:user_id]

    if params[:password].nil?
        {error: "Missing password parameter"}.to_json
    end


    if user_id 
        user = User.update(user_id, "password", params[:password])
        result = {
            "id" => user.id,
            "firstname" => user.firstname,
            "lastname" => user.lastname,
            "age" => user.age,
            "email" => user.email
        }
        result.to_json
    else
        status 401
        { error: "Unauthorized" }.to_json
    end
end

delete '/sign_out' do
    user_id = session[:user_id]
    if user_id
        session.clear
        status 204
    else
        status 401
    end
end

delete '/users' do
    user_id = session[:user_id]
    if user_id
        session.clear
        #the following line is in conflict with the test for delete '/users'. comment it out
        #together with a line pointed out in get '/users' to pass this test, but then
        #the get '/users' test fails
        User.destroy(user_id) 
        status 204
    else
        status 401
    end
end