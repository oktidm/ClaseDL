class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	before_action :load_user, only: [:twitter, :facebook]

	def twitter
		sign_in_or_finish_signup("twitter")
	end

	def facebook
		sign_in_or_finish_signup("facebook")
	end

	def after_sign_in_path_for(user)
		return super(user) if user.email_verified?
		edit_finish_signup_path(user)
	end



	private

	def sign_in_or_finish_signup(login_type)
		if @user.persisted?
			sign_in_and_redirect(@user, event: :authentication)
		else
			session["devise.#{login_type}_data"] = env["omniauth.auth"]
			redirect_to new_user_registration_url
		end

	end


	def load_user
		@user ||= User::FindOrCreateByOauth.new(
			oauth: env["omniauth.auth"], current_user: current_user
			).call
	end
end