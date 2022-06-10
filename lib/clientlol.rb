require 'net/http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

class LeagueApi 

    LOL_URL_BR1 = 'https://br1.api.riotgames.com/lol/'
    LOL_URL_AMERICAS = 'https://americas.api.riotgames.com/'
    API_KEY = ENV['API_KEY']

    def champion_rotations
        uri = URI(LOL_URL_BR1 + 'platform/v3/champion-rotations')
        params = {:api_key => API_KEY }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        JSON.parse(res.body)
    end

    def tournaments
        uri = URI(LOL_URL_BR1 + 'clash/v1/tournaments')
        params = {:api_key => API_KEY }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        JSON.parse(res.body)
    end

    def puuid
        puts 'whats u game name?'
        @game_name = gets.chomp
        puts 'whats u game tag?'
        @tag = gets.chomp.to_s
        uri = URI(LOL_URL_AMERICAS+ 'riot/account/v1/accounts/by-riot-id/'+ @game_name +'/'+@tag)
        params = {:api_key => API_KEY }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        JSON.parse(res.body)['puuid']
        
    end

    def account
        puts 'whats u game name?'
        @game_name = gets.chomp
        puts 'whats u game tag?'
        @tag = gets.chomp.to_s
        uri = URI(LOL_URL_AMERICAS + 'riot/account/v1/accounts/by-riot-id/'+ @game_name +'/'+@tag)
        params = {:api_key => API_KEY }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        @puuid = JSON.parse(res.body)['puuid']
        uri = URI(LOL_URL_AMERICAS + 'riot/account/v1/accounts/by-puuid/' + @puuid)
        params = {:api_key => API_KEY }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        JSON.parse(res.body)
    end

    def lol_status
        uri = URI(LOL_URL_BR1 + 'status/v4/platform-data')
        params = {:api_key => API_KEY}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        JSON.parse(res.body)
    end
end

req = LeagueApi.new
puts req.account

