require 'dotenv'

Dotenv.load

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

end