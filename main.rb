require 'httparty'
require 'json'
require 'yaml'

require_relative 'hs_session'
require_relative 'create_config'

# main RFID Register Class
class Register
  def initialize
    config = YAML.load_file('config.yaml')
    @base_url = config['base_url']
    @api_path = config['api_path']
    @api_key = config['api_key']
    @location = @base_url + @api_path
  end

  def login(carduid, time)
    hs_sess = HsSession.new(carduid, time)
    result =  hs_sess.post(@location, @api_key)
    'error' unless result['message'] == 'OK'
    puts "the card #{hs_sess.uid} signed in at #{hs_sess.current_time}"
  end
end

register = Register.new

register.login('FFFFFF', Time.now.getutc)
