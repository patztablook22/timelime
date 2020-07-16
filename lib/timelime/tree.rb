module Timelime

  class Tree

    @todo

    def initialize paths

      @todo = []
      paths.each do |path|
        @todo += walk path
      end

    end

    def get(&block)

      unless block == nil
        @todo.each do |path|
          yield path
        end
      end

      @todo

    end

    private

    def walk path

      unless File.exist? path
        return []
      end

      buf = []

      if File.directory? path
        Dir[path + "/*"].each do |p|
          buf += walk p
        end
      else
        buf += [path]
      end

      buf

    end

  end

end
