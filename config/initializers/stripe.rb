

if Rails.env.production?

	Rails.configuration.stripe = {
	  :publishable_key => ENV['stripe_publishable_key_pro'],
	  :secret_key      => ENV['STRIPE_SECRET_KEY_PRO']
	}

	Stripe.api_key = Rails.configuration.stripe[:secret_key]

 else

	 Rails.configuration.stripe = {
	  :publishable_key => ENV['stripe_publishable_key'],
	  :secret_key      => ENV['STRIPE_SECRET_KEY']
	}

	Stripe.api_key = Rails.configuration.stripe[:secret_key]

end