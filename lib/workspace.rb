require 'dotenv'

require_relative 'user'
require_relative 'channel'


Dotenv.load

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list
    @channels = Channel.list
  end



  def find_recipient(input)
    if
      @users.find do |user|
        if user.slack_id.downcase == input.downcase || user.name.downcase == input.downcase
          return user
          # ["-User Details-", "Slack ID: #{user.slack_id}", "Name: #{user.name}", "Real Name: #{user.real_name}", "Status Emoji: #{user.status_emoji}"]
        end
      end
    elsif
      @channels.find do |channel|
        if channel.slack_id.downcase == input.downcase || channel.name.downcase == input.downcase
          return channel
          #["-Channel Details-", "Slack ID: #{channel.slack_id}", "Name: #{channel.name}", "Topic: #{channel.topic}", "Member Count: #{channel.member_count}"]
        end
      end
    else
      return "Not found, please select a new recipient"
    end
  end



end

