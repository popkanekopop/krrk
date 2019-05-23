class WelcomeController < ApplicationController
  def index
    @challenge = current_user.challenges.build if logged_in?
  end
end
