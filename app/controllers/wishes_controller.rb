require 'foursquare'

class WishesController < ApplicationController
  def index
    @wishes = Wish.where(user_id: current_user.id)
    @checkins = Foursquare.checkins(current_user.token)
  end

  def create
    @wish = Wish.new(wish_params)
    @wish.save
    redirect_to user_wishes_path
  end

  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    redirect_to user_wishes_path
  end

  private
  def wish_params
    params.require(:wish).permit(:venue_name, :venue_photo, :user_id)
  end
end