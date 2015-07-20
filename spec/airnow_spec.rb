require './airnow.rb'

describe AirNowRequestBuilder do
  describe '#new' do
    it 'requires zip param' do
      expect {
        AirNowRequestBuilder.new(api_key: '12345')
      }.to raise_error(KeyError)
    end

    it 'requires api_key param' do
      expect {
        AirNowRequestBuilder.new(api_key: '12345')
      }.to raise_error(KeyError)
    end

    it 'provides defaults for :format, :date, and :distance' do
      request = AirNowRequestBuilder.new({
                  zip:     '12345',
                  api_key: '123445' 
                })

      expect(request.format).to eq("application/json")
      expect(request.date.class).to eq(Date)
      expect(request.distance).to eq(25)
    end

    it 'should allow setting :format, :date, and :distance' do
      request = AirNowRequestBuilder.new({
                  zip:      '12345',
                  api_key:  '123445',
                  format:   'fake/format',
                  date:     '2015-10-20',
                  distance: 50
                })

      expect(request.format).to eq('fake/format')
      expect(request.date).to eq('2015-10-20')
      expect(request.distance).to eq(50)
    end
  end

  describe '#create' do
    it 'should return an string' do
      request = AirNowRequestBuilder.new(
        {
          zip:     '12345',
          api_key: '123445'
        }).create

      expect(request.class).to eq(String)
    end

    it 'should return the expected request url' do
      request = AirNowRequestBuilder.new(
        {
          zip:     '12345',
          api_key: '123445',
          date:    '2015-11-11'
        }).create
      expected = "http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=12345&date=2015-11-11&distance=25&API_KEY=123445"

      expect(request).to eq(expected)
    end
  end
end
