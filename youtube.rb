require 'youtube-dl.rb'
require_relative 'regexes.rb'
require_relative 'config_loader.rb'

def download_youtube(url)
  name = "#{CONFIG['music']['dir']}/#{$youtube_url.match(url)[1]}.wav"
  if !File.file? name
    YoutubeDL.download(url, {
        output: name,
        extract_audio: true,
        audio_format: 'wav'
      })
  end
end
