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

    def self.get (url, query)
      HTTParty.get(url, query)
      # return new_query
    end

    def self.load_all
    #   url = "https://slack.com/api/channels.list"
    #   response = self.get(url, query:
    #       {
    #           token:
    #       }
    #   )
    #
      response = HTTParty.get("https://slack.com/api/conversations.list", query: {
          token: ENV["SLACK_TOKEN"]
      }
      )

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


  end

