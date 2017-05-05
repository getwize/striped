class Users::SessionsController < Devise::SessionsController
	layout 'signin', only: [:new]
end