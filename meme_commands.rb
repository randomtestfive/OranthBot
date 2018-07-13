require_relative 'regexes.rb'
require_relative 'meme.rb'

formats = [ "whowouldwin", "youvstheguy", "drake", "expandingbrain", "carsalesman" ]

url_regex = /https:\/\/.+\.(png|jpg)/

def find_user(id, mentions)
  o = nil
  mentions.each do |mention|
    if mention.id.to_s == id.to_s
      o = mention
    end
  end
  o
end

def transform_args(args, mentions)
  args.map! do |arg|
    o = arg
    puts arg
    /<\@\!?(\d+)>/.match(arg)do |m|
      o = find_user(m[1], mentions).avatar_url
    end
    o
  end
end

$meme_create_command = Proc.new do |event|
  m = $meme_create_regex.match(event.content)
  if formats.include? m[1]
    message = event.respond "Attempting to create meme..."
    args = m[2].split("|")
    args.map!(&:strip)
    transform_args(args, event.message.mentions)
    # event.respond args.to_s
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
    when "carsalesman"
      Meme.car_salesman args[0], args[1], args[2]
      message.edit "Created meme"
      event.channel.send_file(File.open("memes/tmp-0.png"))
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
