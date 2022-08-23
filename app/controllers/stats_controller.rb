class StatsController < ApplicationController
  before_action :authenticate_user!
  before_action :only => [:index] do
    redirect_to root_path unless current_user && current_user.admin?
  end

  def index
  end
end
