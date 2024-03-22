require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:new_square_calc)
end

get("/square/new") do
  erb(:new_square_calc)
end

get("/square/results") do
  @user_input = params.fetch("square_number").to_f
  @square = @user_input * @user_input
  erb(:square_results)
end

get("/square_root/new") do
  erb(:new_square_root)
end

get("/square_root/results") do
  @user_input_square = params.fetch("square_root_number")
  @square_root = Math.sqrt(@user_input_square.to_f)
  erb(:square_root_results)
end

get("/payment/new") do
  erb(:new_payment_calc)
end

get("/payment/results") do
  @apr = params.fetch("user_apr").to_f
  @years = params.fetch("user_years").to_i
  @principal = params.fetch("user_pv").to_f

  @periods = @years * 12

  def calculate_monthly_payment(apr, periods, principal)
    # change annual apr to monthly and percentage to decimal
    monthly_apr = apr / 12.0 / 100.0 

    numerator = principal * monthly_apr
    denominator = 1 - (1 + monthly_apr) ** -periods
    monthly_payment = numerator / denominator
  end

  @payment = calculate_monthly_payment(@apr, @periods, @principal)

  @formatted_apr = format("%.4f%%", @apr)
  @formatted_principal = @principal.to_fs(:currency) 
  @formatted_payment = @payment.to_fs(:currency) 

  erb(:payment_results)
end

get("/random/new") do
  erb(:new_random_calc)
end

get("/random/results") do
  @user_min = params.fetch("user_min").to_f
  @user_max = params.fetch("user_max").to_f
  @random_number = rand(@user_min..@user_max)
  erb(:random_results)
end
