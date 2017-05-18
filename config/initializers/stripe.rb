
	Rails.configuration.stripe = {
	  :publishable_key => ENV['stripe_publishable_key_pro'],
	  :secret_key      => ENV['STRIPE_SECRET_KEY_PRO']
	}

	
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
