#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'json'
require 'cgi'

# Simple ruby client to read the json response from the web app when quering
# with the passed search term
module ClientModule
  class Client
    def fetch(search)
      escaped = CGI.escape(search)
      url = "http://localhost:3000?q=#{escaped}"

      begin 
        response = JSON.parse(open(url, "Content-Type" => "application/json",
                                   "Accept" => "application/json").read)
      rescue => e
        if OpenURI::HTTPError
          puts "Invalid search term"
        else
          raise e
        end
        abort
      end

      reg_num = response[0]["reg_number"] 
      found = response[0]["found"]

      return found ? reg_num : "Organisation not found"
    end
  end

  if __FILE__ == $PROGRAM_NAME
    client = ClientModule::Client.new
    if ARGV.length == 0
      puts "Enter an organiation name as search argument"
    else
      puts client.fetch(ARGV.join("+"))
    end
  end
end
