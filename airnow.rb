require 'date'
require 'open-uri'
require 'json'

class AirNowRequestBuilder
  def initialize params={}
    @zip         = params.fetch(:zip)
    @format      = params.fetch(:format, "application/json")
    @date        = params.fetch(:date, Date.parse(Time.now.to_s))
    @distance    = params.fetch(:distance, 25)
    @api_key     = params.fetch(:api_key)
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
