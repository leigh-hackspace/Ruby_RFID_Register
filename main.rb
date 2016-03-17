require 'httparty'
require 'json'
require 'optparse'
require 'yaml'

require_relative 'hs_session'
require_relative 'create_config'

config = YAML.load_file('config.yaml')

base_url = config['base_url'] #"http://127.0.0.1:3000"
api_path = config['api_path'] #"/v1/hs_session"
api_key = config['api_key']
location = base_url + api_path

hs_sess = Hs_Session.new("FFFFFF","2016-03-01")
puts hs_sess.Post(location,api_key)
puts "the card#{hs_sess.GetUid} signed in at #{hs_sess.GetCurrent_Time}"
