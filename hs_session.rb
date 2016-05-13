require 'httparty'
# Hackspace User 'sign in' class
class HsSession
  attr_reader :uid

  attr_writer :uid

  def initialize(uid)
    @uid = uid
  end

  def post(url, _apikey)
    options = {
      body: {
        uid: @uid
      }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    }
    @result = HTTParty.post(url.to_s, options)
  end
end
