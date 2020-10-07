require 'dotenv'

require_relative 'user'
require_relative 'channel'

Dotenv.load

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.load_all
    @channels = []
  end

end