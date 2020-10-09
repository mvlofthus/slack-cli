require 'dotenv'

require_relative 'user'
require_relative 'channel'

Dotenv.load

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected_recipient

  def initialize
    @users = User.list
    @channels = Channel.list
    @selected_recipient = nil
  end

  def list_users
    return tp @users, "slack_id", "username", "real_name"
  end

  def list_channels
    return tp @channels, "name", "topic", "member_count", "slack_id"
  end

  def select_user(id)
    @users.each do |user|
      if user.slack_id.downcase == id || user.username.downcase == id
        @selected_recipient = user
        puts "Valid user selected"
        return @selected_recipient
      end
    end
    puts "User does not exist"
  end

  def select_channel(id)
    @channels.each do |channel|
      if channel.slack_id.downcase == id || channel.name.downcase == id
        @selected_recipient = channel
        puts "Valid channel selected"
        return @selected_recipient
      end
    end
    puts "Channel does not exist"
  end

  def find_details
    return @selected_recipient.details
  end

  def send_msg(message)
    Recipient.send_msg(message, @selected_recipient.slack_id)
  end

end

