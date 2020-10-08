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

  def list_users(workspace)
    tp workspace.users, "slack_id", "username", "real_name"
  end

  def list_channels(workspace)
    tp workspace.channels, "name", "topic", "member_count", "slack_id"
  end

  def select_user(id)
    users.each do |user|
      if user.slack_id.downcase == id || user.username.downcase == id
        # user.details(id)
        return tp user
        # "USER FOUND!\n" tp user.slack_id, Username: #{user.username}, Name: #{user.real_name}"
      end
    end
    return "User does not exist"
  end

  def select_channel(id)
    channels.each do |channel|
      if channel.slack_id.downcase == id || channel.name.downcase == id
        return tp channel
      end
    end
    return "Channel does not exist"
  end

  def user_details(id)
    return User.details
  end

  def channel_details(id)

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

