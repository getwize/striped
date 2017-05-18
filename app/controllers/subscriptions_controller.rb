class SubscriptionsController < ApplicationController
	before_action :authenticate_user!

#resubscribes a user who has cancelled
	def create
		if Rails.env.production?
     		 Stripe.api_key = ENV['Javier_Secret_Key']

    	else
     		 Stripe.api_key = ENV['STRIPE_SECRET_KEY']
     	end

		 subscription = Stripe::Subscription.retrieve(current_user.sub_id)
		 subscription.plan = current_user.plan_id
		 subscription.save
		 redirect_to root_path


	end
	#updates a plan for a user
	def update
		@user = current_user
		plan = Plan.find_by!(id: (params[:user][:plan_id]).to_i)
		@user.role = User.roles[plan.stripe_id]
		@user.update_attributes(plan_params)

		
		if Rails.env.production?
     		 Stripe.api_key = ENV['Javier_Secret_Key']

    	else
     		 Stripe.api_key = ENV['STRIPE_SECRET_KEY']
     	end

		 subscription = Stripe::Subscription.retrieve(current_user.sub_id)
		 subscription.plan = current_user.plan.stripe_id
		 subscription.save
		 redirect_to root_path

	end
	#cancels/pauses a plan
	def destroy
		if Rails.env.production?
     		 Stripe.api_key = ENV['Javier_Secret_Key']

    	else
     		 Stripe.api_key = ENV['STRIPE_SECRET_KEY']
     	end

		 subscription = Stripe::Subscription.retrieve(current_user.sub_id)
		 subscription.delete(:at_period_end => true)

		 redirect_to root_path
	end

	private
	def plan_params
	    params.require(:user).permit(:plan_id)
	end

end
