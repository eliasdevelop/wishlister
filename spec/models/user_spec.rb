require 'rails_helper'

describe User do
  it "has valid user" do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it "has many wishes" do
    user = FactoryGirl.build(:user)
    wish = FactoryGirl.build(:wish)

    user.wishes << wish

    expect(wish.user).to be user
  end

  context "has invalid user" do
    it "without name" do
      user = FactoryGirl.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "without token" do
      user = FactoryGirl.build(:user, token: nil)
      expect(user).not_to be_valid
    end
  end
end