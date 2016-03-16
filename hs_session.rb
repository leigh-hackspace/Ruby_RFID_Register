class Hs_Session
  def initialize(uid,current_time)
    @uid =uid
    @current_time = current_time
  end

  def getUid()
    @uid
  end

  def getCurrent_time()
    @current_time
  end
end

