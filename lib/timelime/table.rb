module Timelime

  class Table

    def initialize
      @data = []
      @time = []
      @tags = [
        [], # include
        [], # exclude
      ]
    end

    def time(t)
      t = Timelime::Time.new(t)
      @time += [t]
    end

    def tags(tags, mode)
      tags = Timelime::Tags.new(tags)
      @tags[mode] += [tags]
    end

    def push event

      # check range
      if @time.empty?
        ok = true
      else
        ok = false
      end

      @time.each do |time|
        if event.time.match? time
          ok = true
          break
        end
      end

      unless ok
        return false
      end

      # check tags
      if @tags[0].empty?
        ok = true
      else
        ok = false
      end

      @tags.each_with_index do |tmp, mode|
        tmp.each do |tags|
          if event.tags.has? tags
            case mode
            when 0; ok = true
            when 1; return false
            end
          end
        end
      end

      unless ok
        return false
      end

      @data += [event]
      return true

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
