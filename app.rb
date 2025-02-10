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
  @calculator = "square"
  @number = params[:number].to_f
  @result = @number ** 2
  erb :form
end

get "/square_root/results" do
  @calculator = "square_root"
  @number = params[:number].to_f
  @result = Math.sqrt(@number)
  erb :form
end

get "/payment/results" do
  @calculator = "payment"
  principal = params[:principal].to_f
  apr = params[:apr].to_f
  years = params[:years].to_f
  
  monthly_rate = (apr / 100) / 12
  total_payments = years * 12
  
  if monthly_rate == 0
    @monthly_payment = principal / total_payments
  else
    @monthly_payment = principal * (monthly_rate * (1 + monthly_rate)**total_payments) / ((1 + monthly_rate)**total_payments - 1)
  end
  
  @formatted_payment = @monthly_payment.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  @formatted_payment = "$#{@formatted_payment}"
  
  @formatted_apr = sprintf("%.4f%%", apr)
  @formatted_principal = sprintf("$%s", principal.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse)
  
  erb :form
end

get "/random/results" do
  @calculator = "random"
  min = params[:min].to_i
  max = params[:max].to_i

  if min > max
    min, max = max, min  # Swap if min is greater
  end

  @result = rand(min..max)

  erb :form
end
