require 'httparty'
class Hs_Session
  def initialize(uid,current_time)
    @uid =uid
    @current_time = current_time
  end

  def GetUid()
    @uid
  end

  def GetCurrent_Time()
    @current_time
  end

  def Post(url,apikey)
    @result = HTTParty.post(url.to_s, :body=>{:uid =>@uid}.to_json, :headers=>{'Content-Type'=>'application/json'})
  end
end

