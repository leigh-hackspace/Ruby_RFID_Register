require 'httparty'
require 'json'
require_relative 'hs_session'

base_url = "http://127.0.0.1:3000"
api_path = "/v1/hs_session"
puts base_url + api_path

hs_sess = Hs_Session.new("FFFFFF","2016-03-01")
puts "the card#{hs_sess.getUid} signed in at #{hs_sess.getCurrent_time}"
