require "rails_helper"

describe WishesController do
  context "GET #index" do
    it "assigns @wishes" do
      user = FactoryGirl.create(:user)

      sign_in_as(user)
      wish = FactoryGirl.create(:wish, user: user)

      get :index
      expect(assigns(:wishes)).to eq([wish])
    end
  end
end