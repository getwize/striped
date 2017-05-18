
	Rails.configuration.stripe = {
	  :publishable_key => ENV['Javier_Publishable_Key'],
	  :secret_key      => ENV['Javier_Secret_Key']
	}

	
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
