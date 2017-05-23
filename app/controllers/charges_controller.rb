class ChargesController < ApplicationController
	
before_action :authenticate_user!
	def new
		@user = current_user
  		@plan = Plan.find_by!(id: @user.plan_id)
	end
	#creates a    subscription on stripe
	def create
	  # Amount in cents
	  @user = current_user
	  @plan = Plan.find_by!(id: @user.plan_id)
	  token = params[:stripeToken]

	  if Rails.env.production?
     		 Stripe.api_key = ENV['Javier_Secret_Key']
    else
     		 Stripe.api_key = ENV['STRIPE_SECRET_KEY']
     end

	  customer = Stripe::Customer.create(
	    email: current_user.email,
	    source: token
	  )

	  subscription = Stripe::Subscription.create(
	    :customer    => customer.id,
	    :plan 		 => @plan.stripe_id
	
	  )
	  	 @user.stripe_id  = customer.id
	  	 @user.sub_id = subscription.id
	     @user.save

		rescue Stripe::CardError => e
		  flash[:error] = e.message

		  redirect_to new_charge_path
	end

	def edit
  		@user = current_user
  	end
#updates the card details
  	def update
  		
  		@user = current_user
	  	@plan = Plan.find_by!(id: @user.plan_id)
		if Rails.env.production?
     		 Stripe.api_key = ENV['Javier_Secret_Key']
    	else
     		 Stripe.api_key = ENV['STRIPE_SECRET_KEY']
     	end

		  token = params[:stripeToken]
		  customer = Stripe::Customer.retrieve(@user.stripe_id)
		  customer.source = token 
		  customer.save
		  redirect_to root_path
 	 end
end
