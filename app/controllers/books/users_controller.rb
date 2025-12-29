module Books
  class UsersController < ApplicationController
    allow_unauthenticated_access

    before_action :require_terms_acceptance, only: :create

    def new
    end

    def create
      user = User.new(params.expect(user: [ :email_address, :password, :password_confirmation ]))

      if user.save
        start_new_session_for user
        redirect_to after_authentication_url, notice: "Account created successfully"
      else
        message = user.errors.messages_for(:beta_access).presence || ["There was a problem creating your account"]
        flash.now[:warning] = message.to_sentence
        render :new, status: :unprocessable_content
      end
    end

    private

    def require_terms_acceptance
      return if ActiveModel::Type::Boolean.new.cast(params.dig(:user, :accept_terms))

      flash.now[:warning] = "Please accept the terms"
      render :new, status: :unprocessable_content
    end
  end
end
