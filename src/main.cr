require "option_parser"
require "./App"
require "./Parser"

app = App.new

while true
  print "> "
  inp = gets
  exit if inp.nil?

  payload = Parser.tokenize(inp)

  cmd = payload[0]
  args = payload[1..-1]

  case cmd
  when "dump"
    app.dump
  when "del"
    app.del(args[0])
    app.dump
  when "push"
    app.push(args[0])
    app.dump
  when "edit"
    app.edit(args[0], args[1])
    app.dump
  when "mv"
    app.mv(args[0], args[1])
    app.dump
  when "exit"
    exit
  else
    puts "command not found: #{cmd}"
  end
end
