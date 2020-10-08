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
    puts "[1]'List Users'\n[2]'List Channels'\n[3]'Select User'\n[4]'Select Channel'\n[5]'Details'\n[6]'Quit'"
  end

  puts
  puts "*" * 40
  # puts options

  user_input = nil

  selected_recipient = ["no recipient selected"]
  until user_input == "6" || user_input == "quit"
    puts options
    user_input = gets.chomp.downcase

  case user_input
  when "1", "list users"
    tp workspace.users
  when "2", "list channels"
    tp workspace.channels
  when "3", "select user"
    puts "Please enter User Name or ID"
    user_id = gets.chomp.downcase
    selected_recipient << user_id
    workspace.select_user(user_id)
  when "4", "select channel"
    puts "Please enter Chanel Name or ID"
    channel_id = gets.chomp.downcase
    selected_recipient << channel_id
    workspace.select_channel(channel_id)
  when "5", "details"
    if selected_recipient.length < 2
      puts selected_recipient
    else
      puts workspace.find_recipient(selected_recipient.last)
    end
  end
    end

  puts "Thank you for using the Ada Slack CLI"
  end


main if __FILE__ == $PROGRAM_NAME