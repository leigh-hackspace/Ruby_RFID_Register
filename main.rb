require 'httparty'
require 'json'
require 'yaml'
require 'serialport'
require 'pi_piper'
require 'pry'
require_relative 'hs_session'
require_relative 'create_config'
include PiPiper

# main RFID Register Class
class Register
  def initialize
    config = YAML.load_file('config.yaml')
    @base_url = config['base_url']
    @api_path = config['api_path']
    @api_key = config['api_key']
    @port = config['com_port']
    @location = config['base_url'] + config['api_path']
    init_serial_params
#    @pin = PiPiper::Pin.new(:pin => 1, :direction => :out)
#   @pin.off
  end

  def init_serial_params
    @params = {
      'baud' => 9600,
      'data_bits' => 8,
      'stop_bits' => 1,
      'parity' => SerialPort::NONE
    }
  end

  def login(carduid)
    hs_sess = HsSession.new(carduid)
    result =  hs_sess.post(@location, @api_key)
    'error' unless result['message'] == 'OK'
#    @pin.on
#   sleep 1
#    @pin.off
  end

  def read_serial
    puts 'Hackspace RFID Register'
    puts "Monitoring on #{@port}"
    @sp = SerialPort.new(@port, @params)
    @sp.read_timeout = 200
    loop do
      while (i = @sp.gets) do
        time = Time.now.getlocal("+01:00")
        login(JSON.parse(i)['CardUID'])
	puts  "debug info:CardUID:#{JSON.parse(i)['CardUID']}\n"
      end
    end
  end
end

register = Register.new
puts "the time is: #{Time.now.getlocal("+01:00")}"
register.read_serial
