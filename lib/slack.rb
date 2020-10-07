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
    puts "[1]'List Users'\n[2]'List Channels'\n[3] 'Quit'"
  end

  puts
  puts "*" * 40
  # puts options

  user_input = nil
  until user_input == "3" || user_input == "quit"
    puts options
    user_input = gets.chomp.downcase

    case user_input
    when "1", "list users"
      tp workspace.users
    when "2", "list channels"
      tp workspace.channels
    end
  end

  puts "Thank you for using the Ada Slack CLI"
  end


main if __FILE__ == $PROGRAM_NAME