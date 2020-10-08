require_relative 'test_helper'

describe User do
  describe 'User instantiation' do
    before do
      slack_id = "U01CT3X9L2C"
      username = "water_mmmkay"
      real_name = "Water MmmKay"
      status_emoji = ""
      name = ""
      @user= User.new(slack_id, username, real_name, status_emoji, name)

    end

    it 'is an instance of User' do
      expect(@user).must_be_kind_of User
    end

  end
end