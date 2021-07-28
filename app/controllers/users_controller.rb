class UsersController < ApplicationController

  def index
    @users = User.all.order(name: :asc)
  end

  def birthdays
    @months = [1,2,3,4,5,6,7,8,9,10,11,12]
    @users = User.all
  end

end