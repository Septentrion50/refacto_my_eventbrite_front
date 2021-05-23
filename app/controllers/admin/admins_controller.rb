module Admin
  class AdminsController < ApplicationController

    def index
      @users = User.all
    end

  end
end
