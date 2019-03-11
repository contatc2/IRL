class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @referral = Referral.new
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
