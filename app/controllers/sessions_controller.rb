require 'foursquare'

class SessionsController < ApplicationController
  def new
    @authorize_url = "http://foursquare.com/oauth2/authenticate?client_id=TGA3FYCRCOEICZOAVEAHQUHM0Y5QC3QULWMPXXVNRWTBWYWC&response_type=code&redirect_uri=http://localhost:3000/sessions/callback"
  end

  def callback
    callback_url = Foursquare.connect("https://foursquare.com/oauth2/access_token?client_id=TGA3FYCRCOEICZOAVEAHQUHM0Y5QC3QULWMPXXVNRWTBWYWC&client_secret=D4YMN44D1Z1GD50NNFVYMLZDQRMHC3C3G0XTQKJAQRMTNRWI&grant_type=authorization_code&redirect_uri=http://localhost:3000/sessions/callback&code=#{params[:code]}")
    @token = Foursquare.get_token(callback_url)
    user_info = Foursquare.json_parse("https://api.foursquare.com/v2/users/self?oauth_token=#{@token}&v=20151030")

    auth_user(user_info)
  end

  def auth_user(json)
    user = User.where(token: @token).first

    if user
      sign_in(user)
    else
      sign_up(json)
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
    current_user
    redirect_to user_wishes_path(user.id)
  end

  def sign_up(json)
    user = User.new
    user.name = json["response"]["user"]["firstName"]
    user.last_name =  json["response"]["user"]["lastName"]
    user.token = @token
    user.photo = "#{json["response"]["user"]["photo"]["prefix"]}300x300#{json["response"]["user"]["photo"]["suffix"]}"
    user.save

    sign_in(user)
  end
end