class StudentSubscriptionsController < ApplicationController
	before_action :authenticate_user!
#subscribes a new student to stripe
	
	
	#resubscribes cancelled students

	def update
		@student = Student.find_by(id: params[:id])
		@user = current_user
		if @student.sub_id == nil
			
		    @plan = Splan.find_by!(id: @student.splan_id)

		    Stripe.api_key = ENV['Javier_Secret_Key']

		      token = params[:stripeToken]

		      customer = Stripe::Customer.create(
		      email: current_user.email,
		      source: token
		       )
		      subscription = Stripe::Subscription.create(
		      :customer    => customer.id,
		      :plan      => @plan.stripe_id
		         )

		      @student.stripe_id = customer.id
		      @student.sub_id = subscription.id
		      @student.save
		      redirect_to root_path

      else
		Stripe.api_key = ENV['Javier_Secret_Key']

		@plan = Splan.find_by!(id: @student.splan_id)
		 subscription = Stripe::Subscription.retrieve(@student.sub_id)
		 subscription.plan = @plan.stripe_id
		 subscription.save
		 redirect_to root_path
		end
	end

	#cancels/pauses a plan
	def destroy
		@user = current_user
		@student = Student.find_by(id: params[:id])
		Stripe.api_key = ENV['Javier_Secret_Key']
		 subscription = Stripe::Subscription.retrieve(@student.sub_id)
		 subscription.delete(:at_period_end => true)

		 redirect_to root_path
	end

	private
	def plan_params
	    params.require(:splan).permit(:splan_id)
	end
end
