module Timelime

  class Event

    attr_accessor :head, :time, :tags

    def initialize(rawHead = "")
      @head = Timelime::Head.new(rawHead)
      @time = Timelime::Time.new
      @tags = Timelime::Tags.new
    end

    def complete?
      [
        @head,
        @time,
      ].each do |d|
        if d.data.length == 0
          return false
        end
      end

      return true

    end

  end

end
