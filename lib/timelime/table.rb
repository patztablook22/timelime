module Timelime

  class Table

    def initialize
      @data = []
    end

    def push event
      @data += [event]
    end

    def get &block
      @data.each do |e|
        yield e
      end
    end

    def size
      tmp = 0
      @data.each do |e|
        tmp += e.time.size
      end
      tmp
    end

    def range
      min = nil
      max = nil
      @data.each do |e|
        if min.nil? or e.time.data[0] < min
          min = e.time.data[0]
        end
        if max.nil? or e.time.data[-1] > max
          max = e.time.data[-1]
        end
      end
      [min, max]
    end

  end

end
