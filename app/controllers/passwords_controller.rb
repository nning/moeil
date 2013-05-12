class PasswordsController < ApplicationController
  def update
    unless params[:password1].nil?
      if params[:password1] == params[:password2]
        @hash = Password::Crypt::SHA512.new(params[:password1]).to_s
      else
        flash[:error] = 'Passwords missmatch.'
        redirect_to root_path
      end
    end
  end
end
