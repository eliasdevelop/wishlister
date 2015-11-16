require 'rails_helper'

describe Wish do
  it "has valid wish" do
    wish = FactoryGirl.build(:wish)
    expect(wish).to be_valid
  end

  it "belongs to user" do
    user = FactoryGirl.build(:user)
    wish = FactoryGirl.build(:wish)

    user.wishes << wish

    expect(wish.user).to be user
  end

  context "has invalid wish" do
    it "without venue name" do
      wish = FactoryGirl.build(:wish, venue_name: nil)
      expect(wish).not_to be_valid
    end

    it "without user id" do
      wish = FactoryGirl.build(:wish, user_id: nil)
      expect(wish).not_to be_valid
    end
  end
end