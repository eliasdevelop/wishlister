class User < ActiveRecord::Base
  has_many :wishes

  validates_presence_of :name, :token
end
