class Wish < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :venue_name, :user_id

end
