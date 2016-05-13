require 'httparty'
require 'json'
require 'yaml'
require 'serialport'

require_relative 'hs_session'
require_relative 'create_config'

# main RFID Register Class
class Register
  def initialize
    config = YAML.load_file('config.yaml')
    @base_url = config['base_url']
    @api_path = config['api_path']
    @api_key = config['api_key']
    @port = config['com_port']
    @location = config['base_url'] + config['api_path']
    @bst = config['bst']	
    init_serial_params
  end

  def init_serial_params
    @params = {
      'baud' => 9600,
      'data_bits' => 8,
      'stop_bits' => 1,
      'parity' => SerialPort::NONE
    }
  end

  def login(carduid, time)
    hs_sess = HsSession.new(carduid, time)
    result =  hs_sess.post(@location, @api_key)
    'error' unless result['message'] == 'OK'
  end

  def read_serial
    puts 'Hackspace RFID Register'
    puts "Monitoring on #{@port}"
    @sp = SerialPort.new(@port, @params)
    @sp.read_timeout = 200
    loop do
      while (i = @sp.gets) do
        time = Time.now.getlocal("+01:00")
        login(JSON.parse(i)['CardUID'], time)
	puts  "debug info:CardUID:#{JSON.parse(i)['CardUID']}\n"
      end
    end
  end
end

register = Register.new
puts "the time is: #{Time.now.getlocal("+01:00")}"
register.read_serial
