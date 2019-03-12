class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      @referral = Referral.new
    end
  end

  def about
  end

  def terms_and_conditions
  end

  def test
  end

  def fblogin
  end
end
