module Timelime

  class Axis

    @table
    @buffer
    @begin
    @length
    @lines

    def initialize table
      @table = table
    end

    def generate precision = 10

      @buffer = []
      range = @table.range
      @begin = range[0]
      @length = range[1] - range[0]
      size = @table.size
      @lines = size * precision

      for i in 0...@lines
        @buffer += [
          [
            [], # ranges -> L side
            [], # normal -> R side
          ]
        ]
      end

      # ranges
      @table.get do |e|
        unless e.time.size == 2
          next
        end
      end

      # normal
      @table.get do |e|
        unless e.time.size == 1
          next
        end
        todo = lines(e.time)[0]
        @buffer[todo][1] += [e.head.to_s]

      end

    end

    def dump &block
      @buffer.each do |line|
        tmp = line[0].to_s + "|" + line[1].to_s
        yield tmp
      end
    end

    private

    def lines time
      tmp = time.data.map do |yr|
        (1.0 * @lines * (yr - @begin) / @length).to_i - 1
      end
      tmp
    end

  end

end
