require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ApoExController < ApplicationController
  # Main
  def allabolag
    search = params[:q]
    if not search.nil?
      fetch
    end

    @searches = Result.all
    respond
  end

  # Search
  def fetch
    search = CGI.escape(params[:q])
    if search.empty?
      @warning = "You must enter a search term"
      @result = nil
    else
      @warning = nil

      db_lookup = Result.search(search)
      # Use cache if search term is present
      if db_lookup.empty? or db_lookup.first.found == false
        result = scrape(search)
        found = false
        reg_num = ""

        if result.nil?
          @result = "Registration number not found"
        else
          reg_num = result.text[/\d{6}\-\d{4}/]
          @result = reg_num
          found = true
        end

        ResultsController.create(search, found, reg_num)
      else
        @result = db_lookup.first.reg_number
      end
    end
  end

  # Scrape the result from allabolag.se
  def scrape(search)
    url = "http://www.allabolag.se/?what=#{search}"

    doc = Nokogiri::HTML(open(url))
    # Use the first hit as the most relevant
    return doc.css(".hitlistRow").first.at_css(".text11grey6")
  end

  # Generate json and xml from the stored data
  def respond
    respond_to do |format|
      format.html
      format.xml { render :xml => @searches.to_xml }
      format.json { render :json => @searches.to_json }
    end
  end
end
