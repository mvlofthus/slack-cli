require 'httparty'
require 'table_print'

response = HTTParty.get("https://slack.com/api/users.list", query: {
    token: "xoxb-1222171918129-1435133326080-m7Gx3zpPOoFpTcqts6B4CIGK"
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

puts "####"
tp user_array

