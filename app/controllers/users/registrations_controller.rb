class Users::RegistrationsController < Devise::RegistrationsController
	layout 'signup', only: [:new]

	def after_sign_up_path_for(resource)
		'/users/edit'
	end
end