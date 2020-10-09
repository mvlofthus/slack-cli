require_relative 'test_helper'


describe User do
    before do
      slack_id = "4"
      username = "SlackBot"
      real_name = "SlackBot"
      status_emoji = ''
      name = ""
      @user= User.new(slack_id, username, real_name, status_emoji, name)
      @slack_id = slack_id
      @name = name
      @username = name
      @real_name = real_name
      @status_emoji = ""
      @detail = @user.details

      VCR.use_cassette("SlackBot Users") do
        @response = User.list
      end
    end

    describe 'User instantiation' do
      it 'is an instance of User' do
        expect(@user).must_be_kind_of User
      end

       it 'user.list is an instance of an array' do
        expect(@response).must_be_kind_of Array
        expect(@response.length).must_be_kind_of Integer
        expect(@response.length).must_be_close_to 163  #passes at time of submission
       end

      it 'returns the correct info for members' do
        expect _(@response[1].slack_id).must_equal "U015QQ2BXFZ"
        expect _(@response[2].real_name).must_equal "lisa"
      end
    end
      describe 'User Details' do
        it 'returns a description of a selected user' do
          expect(@detail).must_equal "User found, here's the scoop!\n  Username: #{@name} \n  Slack ID: #{@slack_id}\n  Real Name: #{@real_name}\n  Status Emoji: #{@status_emoji}"
        end

        it 'returns a string' do
          expect(@detail).must_be_kind_of String
        end
      end
end
