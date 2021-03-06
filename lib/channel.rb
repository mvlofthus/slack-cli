require 'httparty'
require 'dotenv'
require 'table_print'

require_relative 'recipient'

Dotenv.load

class Channel < Recipient

  attr_reader :topic, :member_count, :slack_id, :name

  def initialize (slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list
    response = self.get("https://slack.com/api/conversations.list")

    channel_array = []

    response["channels"].each do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      purpose = channel["purpose"]["value"]
      member_count = channel["num_members"]

      temp_channel = self.new(slack_id, name, purpose, member_count)
      channel_array << temp_channel
    end

    return channel_array
  end

  def details
    return "Channel found, here's the scoop!\n  Slack ID: #{slack_id}\n  Name: #{name}\n  Topic: #{topic}\n  Member Count: #{member_count}"
  end

end

