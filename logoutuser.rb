require 'httparty'
require 'json'
require 'yaml'
require 'pi_piper'

require_relative 'hs_session'
require_relative 'create_config'
include PiPiper

class Register
  def initialize
    config = YAML.load_file('config.yaml')
    @base_url = config['base_url']
    @api_path = config['api_path']
    @api_key = config['api_key']
    @port = config['com_port']
    @location = config['base_url'] + config['api_path']
    @pin = PiPiper::Pin.new(:pin =>3, :direction => :out)
  end

  def login(carduid)
    hs_sess = HsSession.new(carduid)
    result =  hs_sess.post(@location, @api_key)
    puts 'login/logout sent for#{carduid}'
    'error' unless result['message'] == 'OK'
  end

end

register = Register.new
puts "the time is: #{Time.now.getlocal("+01:00")}"
@carduid = '0C1D544B'
register.login(@carduid)
