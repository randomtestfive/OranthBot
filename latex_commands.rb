require_relative 'regexes.rb'

$latex_command = Proc.new do |event|
  m = $latex_regex.match(event.content)
  latex = m[1]
  if latex[-3..-1] == '```'
    latex = latex[0..-4]
  end
  File.write('latex/user.tex', latex)
  `cd latex; latex -shell-escape -halt-on-error base.tex; cd ..`
  event.channel.send_file(File.open("latex/base.png"))
end
