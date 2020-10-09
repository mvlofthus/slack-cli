require_relative 'test_helper'
require 'httparty'

describe Recipient do
  before do
    @slack_id = "U0179312KV3"
    @name = "kayla.elizabeth89"
    @recipient  = Recipient.new(@slack_id, @name)
  end

  describe "instantiation" do
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

  it "can send a valid complicated message" do
    VCR.use_cassette("messages take 4") do
      response = Recipient.send_msg("Kayla! I'm testing a longer message with emojis :party_blob: :confused-dog: I'm sorry if this comes through to you multiple times but if it does I at least hope you are able to enjoy the emojis being sent through our bot!! :gem: :unicorn_face: :zap: **FIST BUMP** :right-facing_fist::left-facing_fist: ", "U0179312KV3")
      expect(response.code).must_equal 200
    end
  end

  it "will raise error for invalid address" do
    VCR.use_cassette("messages take 4") do
      expect{Recipient.send_msg("I can post messages!", "mvlofthus")}.must_raise ArgumentError
    end
  end

  it "will raise error for empty message" do
    VCR.use_cassette("messages take 4") do
      expect{Recipient.send_msg("", "U0179312KV3")}.must_raise ArgumentError
    end
  end


end

