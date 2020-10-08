require_relative 'test_helper'
require 'httparty'

describe Recipient do
  it "can send a valid message" do
    VCR.use_cassette("slack-posts") do
      response = Recipient.send_msg("Let's test this!", "kayla.elizabeth89")
      expect(response).must_equal true
    end
  end
end