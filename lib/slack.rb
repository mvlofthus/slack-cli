#!/usr/bin/env ruby
require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "There are #{workspace.channels.count} channels in this workspace"
  puts "There are #{workspace.users.count} users in this workspace."

  # puts "What would you like to do?"
  # puts "Options ('List Users', 'List Channels' 'Quit'). Please type your response below."
  # user_input = gets.chomp
  #
  # puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME