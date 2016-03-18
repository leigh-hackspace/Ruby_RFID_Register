require 'httparty'
# Hackspace User 'sign in' class
class HsSession
  attr_reader :uid
  attr_reader :current_time

  attr_writer :uid
  attr_writer :current_time

  def initialize(uid, current_time)
    @uid = uid
    @current_time = current_time
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
