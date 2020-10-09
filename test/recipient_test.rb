require_relative 'test_helper'
require 'httparty'

describe Recipient do
  before do
    @slack_id = "U0179312KV3"
    @name = "kayla.elizabeth89"
    @recipient  = Recipient.new(@slack_id, @name)
  end

  describe "constructor" do
    it "creates a new Recipient instance" do
      expect(@recipient).must_be_instance_of Recipient
    end
  end

  it "can send a valid message" do
    VCR.use_cassette("messages take 4") do
      response = Recipient.send_msg("I can post messages!", "U0179312KV3")
      expect(response.code).must_equal 200
    end
  end


end

