class BillingsController < ApplicationController
	before_action :authenticate_user!
	def update
		@student = Student.find_by(id: params[:id])
		@user = current_user
		Stripe.api_key = ENV['Javier_Secret_Key']
		subscription = Stripe::Subscription.retrieve(@student.sub_id)
			subscription.trial_end = 1496391694
			subscription.prorate = false
			subscription.save
		redirect_to root_path
	end
end
