require 'httparty'
require 'json'
require 'yaml'

require_relative 'hs_session'
require_relative 'create_config'

class Register
  def initialize
    config = YAML.load_file('config.yaml')
    @base_url = config['base_url']
    @api_path = config['api_path']
    @api_key = config['api_key']
    @port = config['com_port']
    @location = config['base_url'] + config['api_path']
  end

  def login(carduid)
    hs_sess = HsSession.new(carduid)
    result =  hs_sess.post(@location, @api_key)
    puts "login/logout sent for #{carduid}"
    'error' unless result['message'] == 'OK'
  end

end

register = Register.new

ARGV.each {|card|register.login(card)}
