class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home fblogin]

  def home
  end

  def test
  end

  def fblogin
  end
end
