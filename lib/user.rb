equire 'httparty'
require 'dotenv'
require 'table_print'

require_relative 'recipient'

Dotenv.load

class User < Recipient

  attr_reader :slack_id, :name, :real_name

  def initialize (slack_id, name, real_name)
    super(slack_id,name)
    @real_name = real_name
  end

  # def self.get (url, query)
  #   HTTParty.get(url, query)
  #   # return new_query
  # end

  def self.load_all
    # url = "https://slack.com/api/users.list"
    # response = self.get(url, query:
    #     {
    #         token:
    #     }
    # )
    response = HTTParty.get("https://slack.com/api/users.list", query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    user_array = []

    response["members"].each do |user|
      slack_id = user["id"]
      name = user["name"]
      real_name = user["profile"]["real_name"]


      temp_user = self.new(slack_id, name, real_name)
      user_array << temp_user
    end

    tp user_array
    return user_array


  end


end

User.load_all