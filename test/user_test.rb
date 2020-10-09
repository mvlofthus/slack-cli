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

      # VCR.use_cassette("members") do
      #   @response = User.list_all
      # end

    end

    it 'is an instance of User' do
      expect(@user).must_be_kind_of User
    end

    # it 'user.list is an instance of an array'
    # expect(User.list).must_be_kind_of Array
    # expect(User.length).must_be_close_to 1
    # end
end


end

