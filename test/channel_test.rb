require_relative 'test_helper'

describe Channel do
    before do
      slack_id = "111"
      name = "random"
      topic = "random"
      member_count = "79"
      @channel= Channel.new(slack_id, name, topic, member_count)
      @detail = @channel.details
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count

      VCR.use_cassette("random_channel") do
        @response = Channel.list
        end
    end

    it 'is an instance of Channel' do
      expect(@channel).must_be_kind_of Channel
    end

    it 'channel.list is an instance of an array' do
      expect(@response).must_be_kind_of Array
      expect(@response.length).must_be_kind_of Integer
      expect(@response.length).must_be_close_to 48
    end

    it 'returns the correct info for members' do
      expect _(@response[1].slack_id).must_equal "C0165NC8LHH"
      expect _(@response[3].name).must_equal "csmemes"
    end

    it 'returns a description of a selected channel' do
      expect(@detail).must_equal "Channel found, here's the scoop!\n  Slack ID: #{@slack_id}\n  Name: #{@name}\n  Topic: #{@topic}\n  Member Count: #{@member_count}"
    end

    it 'returns a string' do
      expect(@detail).must_be_kind_of String
    end
end

