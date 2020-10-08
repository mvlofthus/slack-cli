#!/usr/bin/env ruby
require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!\n\n"
  workspace = Workspace.new

  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace."

  def options
    puts "\n\nWhat would you like to do?\n"
    puts "Choose the number that corresponds to the following options:"
    puts "[1]'List Users'\n[2]'List Channels'\n[3]'Select User'\n[4]'Select Channel'\n[5]'Details'\n[6]'Send Message'\n[7]'Quit'"
  end

  puts
  puts "*" * 40
  # puts options

  user_input = nil

  until user_input == "7" || user_input == "quit"
    puts options
    user_input = gets.chomp.downcase

    case user_input
    when "1", "list users"
      workspace.list_users
    when "2", "list channels"
      workspace.list_channels
    when "3", "select user"
      puts "Please enter User Name or ID"
      user_identifier = gets.chomp.downcase
      workspace.select_user(user_identifier)
    when "4", "select channel"
      puts "Please enter Chanel Name or ID"
      channel_identifier = gets.chomp.downcase
      workspace.select_channel(channel_identifier)
    when "5", "details"
      if workspace.selected_recipient == nil
        puts "Please select a channel or user first to view details"
      else
        #### puts workspace.find_recipient(workspace.selected_recipient)
        workspace.find_details
      end
    when "6", "send message"
      if workspace.selected_recipient == nil
        puts "Please select a channel or user first to view details"
      else
        puts "Send a message!"
        message = gets.chomp
        workspace.send_msg(message)
      end
  end

  puts "Thank you for using the Ada Slack CLI"
  end

end
main if __FILE__ == $PROGRAM_NAME