module Timelime

  class Time

    attr_reader :data

    def initialize raw = nil
      @data = []
      unless raw.nil?
        push raw
      end
    end

    def size
      @data.size
    end

    def push raw

      unless @data.size == 0
        raise 
      end

      while raw[0] == "*"
        raw = raw[1..-1].lstrip
      end

      while raw[-1] == "*"
        raw = raw[0..-2].rstrip
      end

      era = []
      raw.upcase!
      words = raw.split
      dash = 1

      words.each do |w|

        n = w.to_i

        if n.to_s == w

          if dash != 1
            raise
          end
          dash -= 1
          @data += [n]
          era += [0]
          next

        end

        if @data.size == 0
          raise
        end
          

        if w == "-"
          dash += 1
        elsif w == "CE"
          era[-1] = 1
        elsif w == "BCE"
          era[-1] = -1
        else
          raise
        end

      end

      for i in 0...@data.size
        if era[i] == -1
          @data[i] *= -1
          for j in 0..i
            if era[j] == 0
              @data[j] *= -1
            end
          end
        end
      end

      if @data.size == 2
        if @data[0] > @data[1]
          throw :syntax
        end
      end

    end

    def range!
      if size == 1
        @data += [@data[0]]
      end
      self
    end

    def match? time

      if size == 2
        outer = self.data
        inner = time.data
      else
        outer = time.data
        inner = self.data
      end

      if outer[0] > inner[-1]
        return false
      elsif outer[-1] < inner[0]
        return false
      else
        return true
      end

    end

    def to_s
      buf = ""
      @data.each do |yr|

        unless buf.empty?
          buf += " - "
        end

        if yr >= 0
          buf += yr.to_s
          buf += " CE"
        else
          buf += (yr * -1).to_s
          buf += " BCE"
        end

      end
      buf
    end

  end

end
