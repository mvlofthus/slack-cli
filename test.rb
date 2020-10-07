require 'dotenv'
require 'table_print'
require 'httparty'


Dotenv.load

class Recipient

  attr_reader :slack_id, :name

  def initialize
  @slack_id = slack_id
  @name = name
  end

  def self.get (url, query)
    response = HTTParty.get(url, query: {
        token: ENV["SLACK_TOKEN"],
        format: 'json'
    }
    )
  end
end
  class User #< Recipient

    attr_accessor :real_name, :name, :id

    def initialize(slack_id:nil, name:nil, real_name:nil)
    # super(slack_id: slack_id, name: name)

    @real_name = real_name
    end

    def self.get (url, data)
       HTTParty.get(url, data)
          # return new_query
    end

    def self.list
      url = "https://slack.com/api/users.list"
      response = self.get(url, query:
          {
              token: ENV["SLACK_TOKEN"]
          }
      )

    response["members"].each do |member|
    users = []
      slack_id = member["id"]
      name = member["name"]
      real_name = member["real_name"]

      user = self.new(slack_id: slack_id, name: name, real_name: real_name)
      users << user
    end
      return users
  end
end
pp User.list

#
# url = "https://slack.com/api/users.list"
#
# response = HTTParty.get(url, query:
#     {
#         token: ENV["SLACK_TOKEN"]
#     }
#     )
#
#  response["members"].each do |member|
#   pp member["id"]
#   pp member["real_name"]
#  end
#
#
#
# pp response["members"].count
# pp new = response["members"].map {|member| member ["real_name"]}
# pp #new = response["members"].map {|member| member ["name"]}
#
