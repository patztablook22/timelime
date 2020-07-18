module Timelime

  class Axis

    attr_reader :buffer, :lines

    @table
    @time
    @buffer
    @begin
    @length
    @lines

    def initialize table
      @table = table
    end

    def time(t)
      t = Timelime::Time.new(t)
      @time = t.range!
    end

    def to_b
      true
    end

    def generate precision = nil

      precision = precision.to_i

      @buffer = [
        [], # L side
        [], # R side
      ]
      if @time.nil?
        range = @table.range
      else
        range = @time.data
      end
      @begin = range[0]
      @length = range[1] - range[0]
      if @length == 0
        @length = 1
      end
      size = @table.size

      if precision == 0
        precision = Math.log(@length).to_i
        if precision == 0
          precision = 1
        end
      end
      
      @lines = size * precision

      @table.get do |e|
        squeeze e
      end

    end

    def scale time
      buf = time.data.map do |yr|
        tmp = (1.0 * @lines * (yr - @begin) / @length).to_i
        if tmp == @lines
          tmp = @lines - 1
        end
        tmp
      end
      unless buf.size == 1
        it = buf[0] + 1
        while it < buf[1]
          buf += [it]
          it += 1
        end
      end

      if @time.nil?
        buf
      else
        buf.filter do |l|
          l >= 0 and l < @lines
        end
      end
    end

    def label line
      @begin + @length * line / @lines
    end

    private

    def squeeze event

      todo = scale event.time
      if todo.empty?
        return
      end

      if ( event.time.size == 2)
        side = 0
      else
        side = 1
      end

      found = nil
      @buffer[side].each_with_index do |column, index|
        
        free = true
        todo.each do |line|
          unless column[line].nil?
            free = false
            break
          end
        end

        if free
          found = index
        end

      end
      
      if found.nil?
        @buffer[side] += [Array.new(@lines)]
        found = @buffer[side].size - 1
      end

      todo.each do |line|
        @buffer[side][found][line] = event
      end

    end

  end

end
