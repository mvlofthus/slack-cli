require_relative 'test_helper'

describe Channel do
  describe 'Channel instantiation' do
    before do
      slack_id = "C016J5DP925"
      name = "getting-help"
      topic = "Get some Help!"
      member_count = "79"
      @channel=Channel.new(slack_id, name, topic, member_count)

    end

    it 'is an instance of Channel' do
      expect(@channel).must_be_kind_of Channel
    end

  end
end

