module Timelime

  def self.dump axis

    data = axis.buffer

    for c in 0...data[0].size
      for l in 0...data[0][c].size
        e = data[0][c][l]
        check = [e.to_s, "*"]
        above = data[0][c][l - 1].to_s
        below = data[0][c][l + 1].to_s
        if e.nil?
          next
        elsif check.include? above and check.include? below
          data[0][c][l] = "*"
        end
      end
    end

    data.map! do |s|
      s.map! do |c|
        c.map! do |e|
          if e.nil?
            nil
          elsif e.class == Timelime::Event
            e.head
          else
            "*"
          end
        end
      end
    end

    tabs = [
      Array.new(data[0].size, 0),
      Array.new(data[1].size, 0),
    ]

    for s in 0..1
      for c in 0...data[s].size
        for l in 0...axis.lines
          tmp = data[s][c][l].to_s.length
          if tmp > tabs[s][c]
            tabs[s][c] = tmp
          end
        end
      end
    end

    data[0] = data[0].transpose
    data[1] = data[1].transpose

    buf = []

    for l in 0...axis.lines

      buf += [""]

      for s in 0..1

        data[s][l].each_with_index do |txt, c|

          buf[-1] += tab(txt, tabs[s][c], s)

        end

        if s == 0
          buf[-1] += " │ " + tab(axis.label(l), 6, 0) + " │ "
        end

      end

    end

    buf.each do |line|
      puts line
    end

  end

  private

  def self.tab(txt, num, side = 1)
    txt = txt.to_s
    buf = " "
    if side == 0
      buf += " " * (num - txt.size)
    end
    buf += txt
    if side == 1
      buf += " " * (num - txt.size)
    end
    buf += " "
    buf
  end

end
