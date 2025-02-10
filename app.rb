require "sinatra"
require "sinatra/reloader"

get "/" do
  erb :form, locals: { form_type: nil }
end

get "/square/new" do
  erb :form, locals: { form_type: :square }
end

get "/square_root/new" do
  erb :form, locals: { form_type: :square_root }
end

get "/random/new" do
  erb :form, locals: { form_type: :random }
end

get "/payment/new" do
  erb :form, locals: { form_type: :payment }
end

post "/square/results" do
  number = params[:number].to_f
  @result = number ** 2
  erb :form, locals: { form_type: :square, result: @result }
end

post "/square_root/results" do
  number = params[:number].to_f
  @result = Math.sqrt(number)
  erb :form, locals: { form_type: :square_root, result: @result }
end

post "/random/results" do
  min = params[:min].to_i
  max = params[:max].to_i
  @result = rand(min..max)
  erb :form, locals: { form_type: :random, result: @result }
end

post "/payment/results" do
  principal = params[:principal].to_f
  rate = params[:rate].to_f / 100 / 12
  years = params[:years].to_i
  months = years * 12
  
  numerator = rate * principal
  denominator = 1 - (1 + rate) ** -months
  @monthly_payment = numerator / denominator
  @formatted_payment = @monthly_payment.to_fs(:currency)

  erb :form, locals: { form_type: :payment, result: @formatted_payment }
end
