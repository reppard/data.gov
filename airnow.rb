require 'date'
require 'open-uri'
require 'json'

class AirNowRequestBuilder
  attr_reader :format, :date, :distance
  def initialize params={}
    @zip         = params.fetch(:zip)
    @api_key     = params.fetch(:api_key)
    @format      = params.fetch(:format, "application/json")
    @date        = params.fetch(:date, Date.parse(Time.now.to_s))
    @distance    = params.fetch(:distance, 25)
  end

  def create
    "#{root_url}#{search_string}"
  end

  private
  def root_url
    "http://www.airnowapi.org/aq/forecast/zipCode/"
  end

  def search_string
    [
      "?format=#{@format}",
      "&zipCode=#{@zip}",
      "&date=#{@date}",
      "&distance=#{@distance}",
      "&API_KEY=#{@api_key}",
    ].join('')
  end
end


# When run as a script
if ARGV[0]
  zip_code = ARGV[0].chomp
  request = AirNowRequestBuilder.new(
    {
      zip: zip_code,
      api_key: ENV['API_KEY']
    }
  ).create


  response = JSON.parse(open(request).read)
  formatted = JSON.pretty_generate(response)

  puts response
  puts formatted
end
