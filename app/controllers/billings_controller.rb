class BillingsController < ApplicationController
	before_action :authenticate_user!
	def update
		@student = Student.find_by(id: params[:id])
		@user = current_user
		@params = params[:date]
		@date = Date.new(params[:date]["date(1i)"].to_i,params[:date]["date(2i)"].to_i,params[:date]["date(3i)"].to_i).to_time.to_i
		puts ("#{@date}")
		Stripe.api_key = ENV['Javier_user_Secret_Key']
		subscription = Stripe::Subscription.retrieve(@student.sub_id)
			subscription.trial_end = @date
			subscription.prorate = false
			subscription.save
		redirect_to root_path
	end

	
end
