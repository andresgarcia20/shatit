class StatsController < ApplicationController
  before_action :only => [:index] do
    redirect_to root_path unless current_user.admin?
  end

  def index
  end
end
