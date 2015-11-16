require 'net/http'

module Foursquare

  def self.connect(url)
    Net::HTTP.get(URI(url))
  end

  def self.json_parse(url)
    JSON.parse(connect(url))
  end

  def self.get_token(json)
    result = JSON.parse(json)
    token = result["access_token"]
  end

  def self.recent_checkins(json, token)
    @checkins = {}
    json["response"]["recent"].each do |friend|
      @checkins[friend["id"]] = { user: "#{friend["user"]["firstName"]} #{friend["user"]["lastName"]}",
                                  user_photo: "#{friend["user"]["photo"]["prefix"]}300x300#{friend["user"]["photo"]["suffix"]}",
                                  venue_id: friend["venue"]["id"],
                                  venue_name: friend["venue"]["name"],
                                  venue_photo: venue_image(friend["venue"]["id"], token),
                                  visible: true }
    end
    @checkins
  end

  def self.venue_image(venue_id, token)
    json = json_parse("https://api.foursquare.com/v2/venues/#{venue_id}/photos?oauth_token=#{token}&v=20151030")

    if json["response"]["photos"]["items"].count > 0
      "#{json["response"]["photos"]["items"][0]["prefix"]}300x300#{json["response"]["photos"]["items"][0]["suffix"]}"
    else
      "http://placehold.it/200x200"
    end
  end

  def self.checkins(token)
    json = json_parse("https://api.foursquare.com/v2/checkins/recent?oauth_token=#{token}&limit=10&v=20151030")
    recent_checkins(json, token)
  end
end