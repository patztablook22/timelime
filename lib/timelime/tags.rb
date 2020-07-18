module Timelime

  class Tags

    attr_reader :data

    def initialize raw = nil
      @data = []
      unless raw.nil?
        push raw
      end
    end

    def push raw

      raw.split.each do |tag|

        unless tag[0] == "@" and tag.length > 1
          throw :syntax
        end

        @data += [tag[1..-1]]

      end

    end

    def has? tags
      (@data & tags.data) == tags.data
    end

    def to_s
      buf = ""
      @data.each do |tag|
        unless buf.empty?
          buf += " "
        end
        buf += "@#{tag}"
      end
      buf
    end
    
  end

end
