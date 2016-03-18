require 'httparty'
require 'json'
require 'optparse'
require 'yaml'

require_relative 'hs_session'
require_relative 'create_config'

config = YAML.load_file('config.yaml')

base_url = config['base_url']
api_path = config['api_path']
api_key = config['api_key']
location = base_url + api_path

hs_sess = HsSession.new('FFFFFF', '2016-03-01')
result =  hs_sess.post(location, api_key)
'error' unless result['message'] == 'OK'
puts "the card #{hs_sess.uid} signed in at #{hs_sess.current_time}"
