module Timelime

  class Head

    attr_reader :data

    @data

    def initialize raw
      if raw[0] == "#"
        raw = raw[1..-1]
      end
      @data = raw.strip
    end

    def to_s
      @data.to_s
    end

  end

end
