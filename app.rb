require "sinatra"
require "sinatra/reloader"

get "/" do
  redirect "/square/new"
end

get "/square/new" do
  @calculator = "square"
  erb :form
end

get "/square_root/new" do
  @calculator = "square_root"
  erb :form
end

get "/payment/new" do
  @calculator = "payment"
  erb :form
end

get "/random/new" do
  @calculator = "random"
  erb :form
end

get "/square/results" do
  @number = params[:number].to_f
  @square = @number ** 2
  erb :results
end
