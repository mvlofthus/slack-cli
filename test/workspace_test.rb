require_relative 'test_helper'
require 'httparty'

describe Workspace do
  before do
    VCR.use_cassette("workspace_tests") do
      @workspace = Workspace.new

    end
  end

  describe 'instantiation' do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end
  end


    it "holds user lists, channel lists, and nil selected recipient value" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[1]).must_be_kind_of User
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[1]).must_be_kind_of Channel
      expect(@workspace.selected_recipient).must_be_nil
    end

end

