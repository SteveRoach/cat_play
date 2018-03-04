class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: [:admin]
  
  def about
  end

  def contact
  end

  def journal
  end

  def technical
  end

  def crew
  end

  def gallery
  end

  def admin
  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
