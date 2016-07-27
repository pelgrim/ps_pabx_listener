module PsPabxListener
  class Listener

    attr_reader :connection, :started

    def initialize(host, user, password, timeout=false)
      @host, @user, @password, @timeout = host, user, password, timeout
      validate_attributes
    end

    def start
      unless @started
        @started = true
        connect_to_pabx
      end
    end

    def stop
      if @started
        @started = false
        disconnect_from_pabx
      end
    end

    def get
      if @started
        if @authenticated
          get_more_data
        else
          authenticate_and_start_getting_data
        end
      else
        raise "No connection."
      end
    end

    private

    def validate_attributes
      puts @host.class
      raise 'Invalid host' unless @host.is_a? String
      raise 'Invalid user' unless @user.is_a? String
      raise 'Invalid password' unless @password.is_a? String
      raise 'Invalid timeout' unless @timeout.is_a? FalseClass or @timeout.is_a? Numeric
    end

    def connect_to_pabx
      @connection = Net::Telnet.new({
        "Host" => @host,
        "Port" => 2300,
        "Prompt" => /(\n|\r)/,
        "Timeout" => @timeout,
        "Waittime" => @timeout
        })
    end

    def disconnect_from_pabx
      @connection.close
      @authenticated = false
    end

    # authenticate and get a first chunk of data
    def authenticate_and_start_getting_data
      response = @connection.waitfor(/(-|Rejected)/)
      raise "Connection rejected." if response.include? 'Rejected'
      response += @connection.cmd({
        "String" => @user,
        "Match" => /[Pp]ass(?:word|phrase)[:]*\z/n
        })
      response += @connection.cmd(@password)
      @authenticated = true
      filtered response.split(/\n|\r/)
    end

    # get more chunks of data
    def get_more_data
      response = @connection.waitfor({"Match" => /(\n|\r)/}).split(/(\n|\r)/)
      filtered response
    end

    # filter relevant data
    def filtered raw_data
      raw_data.map { |line| line if line =~ /\A\d{2}\/\d{2}\/\d{2}/ }.compact
    end

  end
end
