require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)
    response = HTTParty.get(url, query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    unless response.code == 200 && response.parsed_response["ok"]
      raise ArgumentError, "SlackApiError. Reason: #{response["error"]}"
    end

    return response
  end

  def self.send_msg(message, id)
    response = HTTParty.post("https://slack.com/api/chat.postMessage",
    body: {
        token: ENV["SLACK_TOKEN"],
        text: message,
        channel: id
    },
    headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
    )

    unless response.code == 200 && response.parsed_response["ok"]
      raise ArgumentError, "SlackApiError. Reason: #{response["error"]}"
    end

    return response
  end


  private

  def self.list
    raise NotImplementedError, 'Implement me in a child class'
  end

  def self.details
    raise NotImplementedError, 'Implement me in a child class'
  end
end