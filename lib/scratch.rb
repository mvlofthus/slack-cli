require 'httparty'
require 'table_print'

response = HTTParty.get("https://slack.com/api/users.list", query: {
    token: ENV["SLACK_TOKEN"]
}
)


pp "#{response["members"].first["id"]}"

USERS CLASS
def self.load_all
  user_array = []
  response["members"].each do |user|
    temp_user = {
        "id" => user["id"],
        "real_name" => user["profile"]["real_name"],
        "user_name" => user["name"]
    }
    user_array << temp_user
  end
end
puts "####"
tp user_array



