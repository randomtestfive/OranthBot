require_relative 'regexes.rb'
require_relative 'meme.rb'

formats = [ "whowouldwin", "youvstheguy", "drake", "expandingbrain" ]

url_regex = /https:\/\/.+\.(png|jpg)/

$meme_create_command = Proc.new do |event|
  m = $meme_create_regex.match(event.content)
  if formats.include? m[1]
    message = event.respond "Attempting to create meme..."
    args = m[2].split("|")
    args.map!(&:strip)
    case m[1]
    when "whowouldwin"
      if args.length == 4 && (url_regex.match(args[1]) != nil) && (url_regex.match(args[3]) != nil)
        Meme.who_would_win args[0], args[1], args[2], args[3]
        message.edit "Created meme"
        event.channel.send_file(File.open("memes/tmp-2.png"))
      else
        message.edit "Couldn't make meme: wrong arguments"
      end
    when "youvstheguy"
      if args.length == 2 && (url_regex.match(args[0]) != nil) && (url_regex.match(args[1]) != nil)
        Meme.you_vs_the_guy args[0], args[1]
        message.edit "Created meme"
        event.channel.send_file(File.open("memes/tmp-2.png"))
      else
        message.edit "Couldn't make meme: wrong arguments"
      end
    when "drake"
      if args.length == 2
        Meme.drake args[0], args[1]
        message.edit "Created meme"
        event.channel.send_file(File.open("memes/tmp-0.png"))
      else
        message.edit "Couldn't make meme: wrong arguments"
      end
    when "expandingbrain"
      if args.length == 4
        Meme.expanding_brain args[0], args[1], args[2], args[3]
        message.edit "Created meme"
        event.channel.send_file(File.open("memes/tmp-0.png"))
      else
        message.edit "Couldn't make meme: wrong arguments"
      end
    end
  else
    event.respond "Invalid format"
  end
end

$meme_list_command = Proc.new do |event|
  event.respond "Available meme formats:
  \twhowouldwin: text|image|text|image
  \tyouvstheguy: image|image
  \tdrake: text|text
  \texpandingbarin: text|text|text|text"
end
