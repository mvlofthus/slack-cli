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
    @username = username
  end


  def self.list
    response = HTTParty.get("https://slack.com/api/users.list", query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    user_array = []
    response["members"].each do |user|
      slack_id = user["id"]
      username = user["name"]
      real_name = user["profile"]["real_name"]
      status_emoji = user["profile"]["status_emoji"]
      name = user["name"]


      temp_user = self.new(slack_id, username, real_name, status_emoji, name)
      user_array << temp_user
    end
    return user_array
  end

  # def self.user_list
  #   all_users = self.load_all
  #
  #   user_list = []
  #
  #   all_users.each do |user|
  #     temp_user = {
  #         "id" => user["id"],
  #         "name" => user["name"],
  #         "real_name" => user["profile"]["real_name"]
  #     }
  #
  #     user_list << temp_user
  #   end
  #
  #   return user_list
  #
  # end





  def self.details
    if self.slack_id.select(identifier) || self["name"].select(identifier)
      return ""
    else
      return "that is not a valid selection"
    end

  end


end