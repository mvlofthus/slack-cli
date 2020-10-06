require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  attr_reader :id #name ?? :user_name, :user_id, :channel_name, :channel_id

  def initialize(id)
    #validate
    @id = id
  end


  def self.get (url)
    response = HTTParty.get(url, query: {
        token: ENV["SLACK_TOKEN"],
        format: 'json'
    }
    )

    unless response.code == 200
      raise ArgumentError, 'Error in request'
    end

    return response
  end




  private

  def self.list
    raise NotImplementedError, 'Implement me in a child class'
  end

  def self.send_message
    raise NotImplementedError, 'Implement me in a child class'

  end




end
