module Timelime

  class Tags

    attr_reader :data

    def initialize 
      @data = []
    end

    def push raw

      raw.split.each do |tag|

        unless tag[0] == "#" and tag.length > 1
          throw :syntax
        end

        @data += [tag[1..-1]]

      end

    end

    def to_s
      @data.to_s
    end
    
  end

end
