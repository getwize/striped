
	Rails.configuration.stripe = {
	  :publishable_key => ENV['stripe_publishable_key_client'],
	  :secret_key      => ENV['STRIPE_SECRET_KEY_CLIENT']
	}

	
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
