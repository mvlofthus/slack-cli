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

    it "holds user lists, channel lists, and nil selected recipient value" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[1]).must_be_kind_of User
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[1]).must_be_kind_of Channel
      expect(@workspace.selected_recipient).must_be_nil
    end
  end

  describe "list methods" do
    it "will print a table for list_users" do
      expect(@workspace.list_users).must_be_kind_of TablePrint::Returnable
    end

    it "will print a table for list_channels" do
      expect(@workspace.list_channels).must_be_kind_of TablePrint::Returnable
    end
  end

  describe "select recipeint" do
    it "will return selected_recipient is user and valid" do
      expect(@workspace.select_user("mvlofthus")).must_be_kind_of Recipient
    end

    it "will return selected_recipient is user and invalid" do
      expect(@workspace.select_user("MVLOFTHUS")).must_be_nil
    end

    it "will return a string if @selected_recipient is channel and valid" do
      name = "C017HQHHHRB".downcase
      expect(@workspace.select_channel(name)).must_be_kind_of Channel
    end

    it "will return a string if @selected_recipient is channel and invalid" do
      name = "C017HQHHHRB"
      expect(@workspace.select_channel(name)).must_be_nil
    end
  end

  describe "find_details" do
    it "will return a string if @selected_recipient is user" do
      @workspace.select_user("mvlofthus")
      expect(@workspace.find_details).must_be_kind_of String
    end

    it "will return a string if @selected_recipient is channel" do
      name = "C017HQHHHRB".downcase
      @workspace.select_channel(name)
      expect(@workspace.find_details).must_be_kind_of String
    end
  end

  describe "send_msg" do
    it "will send a message if selected_recipient is not nil" do
        @workspace.select_user("kayla.elizabeth89")
        VCR.use_cassette("workspace send_msg 1") do
          response = @workspace.send_msg("hola!")
          expect(response.code).must_equal 200
        end
    end

    it "will send a message if selected_recipient is nil (though slack.rb will not let this go through)" do
      VCR.use_cassette("workspace send_msg 2") do
        expect{@workspace.send_msg("hola!")}.must_raise NoMethodError
      end
    end
  end

end

