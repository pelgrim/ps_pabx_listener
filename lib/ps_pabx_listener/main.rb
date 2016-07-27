module PsPabxListener
  class Main

    attr_reader :args, :listener
    attr_accessor :run

    def initialize *args
      @args = args.first
      @args[:timeout] ||= false
      @listener = PsPabxListener::Listener.new(@args[:host],
                                      @args[:user],
                                      @args[:password],
                                      @args[:timeout])
    end

    # disconnects listener after given timeout is reached
    def get_data timeout, &block
      @listener.start
      start_time = Time.now
      runner = Thread.new do
        loop do
          @listener.get.each {|data| yield data}
        end
      end
      sleep 1 while Time.now - start_time < timeout
      runner.exit
      @listener.stop
    end

    # keeps getting data kind of forever and process the data
    def each_data &block
      @listener.start
      @run = true

      Signal.trap("INT") {@run = false}

      runner = Thread.new do
        loop do
          @listener.get.each {|data| yield data}
        end
      end

      sleep 1 while(@run)
      runner.exit
      @listener.stop
    end

  end
end
