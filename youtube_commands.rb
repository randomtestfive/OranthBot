require_relative 'youtube.rb'
require_relative 'regexes.rb'

$music_start_command = Proc.new do |event|
  m = $music_start_regex.match(event.content)
  if $youtube_url.match(m[1]) != nil
    r = event.respond 'downloading...'
    download_youtube(m[1].to_s)
    r.edit 'download complete'
  else
    event.respond 'invalid url'
  end
end

$music_summon_command = Proc.new do |event,bot|
  bot.voice_connect(event.author.voice_channel)
  puts 'connected'
end
