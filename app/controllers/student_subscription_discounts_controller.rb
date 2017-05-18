class StudentSubscriptionDiscountsController < ApplicationController
	before_action :authenticate_user!
	def update
		@student = Student.find_by(id: params[:id])
		@plan = Splan.find_by!(id: @student.splan_id)
		Stripe.api_key = current_user.access_code

		Stripe::Subscription.create(
			  :customer => @student.stripe_id,
			  :plan => @plan.stripe_id,
			  :coupon => "deal",
			)
		redirect_to root_url
	end

end
