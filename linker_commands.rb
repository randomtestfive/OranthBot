# encoding: utf-8
require 'yaml'
require_relative 'regexes.rb'

$links = if File.exists? "links.yml"
  YAML.load_file("links.yml")
else
  Hash.new
end

def save_links
  File.open('links.yml', 'w') do |file|
    file.puts $links.to_yaml
  end
end

$linker_add_command = Proc.new do |event|
  m = $linker_add_regex.match(event.content)
  $links[m[1]] = m[2]
  save_links
  event.respond "Created link `#{m[1]}->#{m[2]}`"
end

$linker_find_match = Proc.new do |event|
  # event.respond $links.to_s
  # event.respond $links.key? event.message.to_s
  event.respond $links[event.content] if $links.key? event.content
end
