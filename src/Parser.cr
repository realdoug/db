class Parser
  QUOT = '"'
  WSP  = Set{'\t', ' '}

  def self.tokenize(inp)
    tokens = [] of String
    buf = String::Builder.new
    quoted = false

    eat = ->{
      tokens << buf.to_s
      buf = String::Builder.new
      quoted = false
    }

    inp.each_char do |ch|
      case ch
      when ' ', '\t'
        if !buf.empty? && !quoted
          eat.call
        elsif !buf.empty?
          buf << ch
        end
      when QUOT
        if quoted
          eat.call
        else
          quoted = true
        end
      else
        buf << ch
      end
    end
    tokens << buf.to_s if !buf.empty?

    tokens
  end
end
