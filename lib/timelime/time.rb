module Timelime

  class Time

    attr_reader :data

    def initialize
      @data = []
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
          throw
        end
      end

    end

    def to_s
      @data.to_s
    end

  end

end
