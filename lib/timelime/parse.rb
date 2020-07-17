module Timelime

  def self.parse path

    lines = IO.readlines(path)
    lines += ["FEND"]
    number = 0
    err = false
    buf = nil

    lines.each do |line|

      number += 1
      begin

        line.rstrip!
        if line.empty?
          next
        end

        # new entry
        if line.lstrip == line
          if !buf.nil? and !err and buf.complete?
            yield buf
          end
          buf = Timelime::Event.new(line)
          err = false
          next
        end

        if err
          next
        end

        line.strip!
        case line[0]
        when "*"
          buf.time.push(line)
        when "#"
          buf.tags.push(line)
        else
        end


      rescue
        err = true
        $stderr.puts "WARN: invalid definition: #{path} line #{number}"
        $stderr.puts "      skipping to next entry"
      end

    end

  end

end
