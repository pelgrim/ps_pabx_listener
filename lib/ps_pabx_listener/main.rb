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
      while (Time.now - start_time < timeout)
        @listener.get.each {|data| yield data}
      end
      @listener.stop
    end

    # keeps getting data kind of forever and process the data
    def each_data &block
      @listener.start
      @run = true

      Signal.trap("INT") {@run = false}

      while(@run) do
        begin
          @listener.get.each {|line| yield line}
        rescue Exception => e
          @listener.stop
        end
      end

      @listener.stop
    end

  end
end