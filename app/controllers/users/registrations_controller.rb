class Users::RegistrationsController < Devise::RegistrationsController
	layout 'signup', only: [:new]
end