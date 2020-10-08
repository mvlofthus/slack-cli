require 'httparty'
require 'dotenv'
require 'table_print'

require_relative 'recipient'

Dotenv.load

class User < Recipient

  attr_reader :slack_id, :username, :real_name, :status_emoji

  def initialize (slack_id, username, real_name, status_emoji, name)
    super(slack_id, name)
    @real_name = real_name
    @status_emoji = status_emoji
    @username = username  #for table print
  end

  def self.list
    response = HTTParty.get("https://slack.com/api/users.list", query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    user_array = []
    response["members"].each do |user|
      slack_id = user["id"]
      username = user["name"] #for table print
      real_name = user["profile"]["real_name"]
      status_emoji = user["profile"]["status_emoji"]
      name = user["name"]

      temp_user = self.new(slack_id, username, real_name, status_emoji, name)
      user_array << temp_user
    end
    return user_array
  end

  def details
    puts "User found, here's the scoop!\n  Username: #{name} \n  Slack ID: #{slack_id}\n  Real Name: #{real_name}\n  Status Emoji: #{status_emoji}"
  end

end